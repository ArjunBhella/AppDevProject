import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Models/users.dart';


class DatabaseHelper{
  final databaseName = "ImmuniDose.db";
  String users = "create table users (user_id INTEGER PRIMARY KEY AUTOINCREMENT, user_name TEXT UNIQUE, password TEXT, email TEXT, hint TEXT)";

  Future<Database>initDB()async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);


    return openDatabase(path,version: 1,onCreate: (db,version) async{
      await db.execute(users);
    });

  }

  Future<bool> login(Users user)async{
    final Database db = await initDB();

    var result = await db.rawQuery("select * from users where user_name = '${user.userName}' "
        "AND password = '${user.password}'");
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  Future<int> signUp(Users user)async{
    final Database db = await initDB();
    
    return db.insert('users', user.toMap());

  }

}