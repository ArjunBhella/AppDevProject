import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/users.dart';
import '../Models/DoctorService.dart';
import '../Models/Doctor.dart';
class DatabaseHelper {
  final String databaseName = "ImmuniDose.db";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(createAppointmentsTable); // Create appointments table
      await db.execute(createTimeSlotsTable);
      await _populateInitialTimeSlots(db);
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute("ALTER TABLE appointments ADD COLUMN doctor_id INTEGER;");
      }
    });
  }

  final String users =
      "CREATE TABLE users (user_id INTEGER PRIMARY KEY AUTOINCREMENT, user_name TEXT UNIQUE, password TEXT, email TEXT, hint TEXT)";

  final String createAppointmentsTable = """
    CREATE TABLE appointments (
      appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_name TEXT,
      appointment_name TEXT,
      date TEXT,
      doctor_id INTEGER,
      FOREIGN KEY (user_name) REFERENCES users (user_name)
    )""";

  final String createTimeSlotsTable = """
    CREATE TABLE time_slots (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      time TEXT UNIQUE
    )""";

  Future<void> _populateInitialTimeSlots(Database db) async {
    const initialTimes = ['12:00 PM', '12:30 PM', '1:00 PM', '1:30 PM', '2:00 PM'];
    for (var time in initialTimes) {
      await db.insert('time_slots', {'time': time});
    }
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    var result = await db.rawQuery("select * from users where user_name = '${user.userName}' "
        "AND password = '${user.password}'");
    return result.isNotEmpty;
  }

  Future<int> signUp(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }

  Future<int> addAppointment(String userName, String appointmentName, String date, int doctorId) async {
    final db = await initDB();
    return await db.insert('appointments', {
      'user_name': userName,
      'appointment_name': appointmentName,
      'date': date,
      'doctor_id': doctorId,
    });
  }

  Future<List<Map<String, dynamic>>> getAppointmentsByUser(String userName) async {
    final db = await initDB();
    return await db.query(
      'appointments',
      where: 'user_name = ?',
      whereArgs: [userName],
    );
  }

  Future<List<String>> getTimeSlots() async {
    final db = await initDB();
    try {
      final List<Map<String, dynamic>> result = await db.query('time_slots');
      return result.map((map) => map['time'] as String).toList();
    } catch (e) {
      // Handle error appropriately, e.g., log or re-throw
      throw Exception("Error fetching time slots: $e");
    }
  }

  Future<int> deleteAppointment(int? appointmentId) async {
    final db = await initDB();
    return await db.delete(
      'appointments',
      where: 'appointment_id = ?',
      whereArgs: [appointmentId],
    );
  }

  Future<bool> isTimeSlotBookedForDoctor(String time, int doctorId) async {
    final db = await initDB();
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM appointments WHERE date = ? AND doctor_id = ?',
      [time, doctorId],
    ));
    // Add a null check before performing the comparison
    return count != null && count > 0;
  }

  Future<Users?> getUserByUsername(String username) async {
    final db = await initDB();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'user_name = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(Users user) async {
    final db = await initDB();
    print("Attempting to update user: ${user.userName}");
    int result = await db.update(
      'users',
      {
        'user_name': user.userName,
        'password': user.password,
        'email': user.email,
        'hint': user.hint,
      },
      where: 'user_name = ?',
      whereArgs: [user.userName],
    );
    print("Update result: $result");
    return result;
  }
  Future<String?> getHintByUsername(String username) async {
    final db = await initDB();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['hint'],
      where: 'user_name = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.first['hint'] as String?;
    } else {
      return null;
    }
  }
}
