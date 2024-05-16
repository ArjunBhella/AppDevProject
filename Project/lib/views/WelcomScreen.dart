import 'package:flutter/material.dart';
import 'package:project/views/ChooseDate.dart';
import 'package:project/views/MyAppointmentsPage.dart';
import 'package:project/views/DoctorsPage.dart';
import '../Models/users.dart'; // Import your Users model
import 'package:project/SQLite/sqlite.dart';

class WelcomeScreen extends StatefulWidget {
  final String username;

  WelcomeScreen({required this.username});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Users? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final dbHelper = DatabaseHelper();
    final user = await dbHelper.getUserByUsername(widget.username);
    setState(() {
      _user = user;
      _isLoading = false;
    });
  }
  void _editProfile() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: _user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        title: Text('Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 45,
                    child: Icon(
                      Icons.person,
                      color: Colors.lightBlue,
                      size: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome ${widget.username}!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Book an Appointment'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookAppointmentScreen(userName: widget.username),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('View My Appointments'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyAppointmentsPage(userName: widget.username),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('View Doctors'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DoctorsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      color: Colors.lightBlue,
                      size: 80,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        '${_user?.userName ?? ''}!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _user?.email ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Hint:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _user?.hint ?? '',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class EditProfileScreen extends StatefulWidget {
  final Users? user;

  EditProfileScreen({this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _hintController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user?.email);
    _hintController = TextEditingController(text: widget.user?.hint);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hintController,
                decoration: InputDecoration(labelText: 'Hint'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hint';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedUser = Users(
                      userName: widget.user!.userName,
                      password: widget.user!.password,
                      email: _emailController.text,
                      hint: _hintController.text,
                    );
                    final dbHelper = DatabaseHelper();
                    await dbHelper.updateUser(updatedUser);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
