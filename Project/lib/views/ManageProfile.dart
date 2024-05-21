import 'package:flutter/material.dart';
import 'package:project/Models/users.dart';
import 'package:project/SQLite/sqlite.dart';
import 'Login.dart';

class ManageProfileScreen extends StatefulWidget {
  final Users? user;

  ManageProfileScreen({this.user});

  @override
  _ManageProfileScreenState createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _hintController;

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user?.userName);
    _emailController = TextEditingController(text: widget.user?.email);
    _passwordController = TextEditingController(text: widget.user?.password);
    _hintController = TextEditingController(text: widget.user?.hint);
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = Users(
        userName: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        hint: _hintController.text,
      );
      final dbHelper = DatabaseHelper();
      print("Updating user...");
      int result = await dbHelper.updateUser(updatedUser);
      if (result > 0) {
        print("User updated successfully");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => LoginApp(),
          ),
              (route) => false,
        );
      } else {
        print("Failed to update user");
      }
    } else {
      print("Form validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Manage Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Update My Account',style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: TextFormField(
                      controller: _hintController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.question_mark),
                        border: InputBorder.none,
                        hintText: 'Hint',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a hint';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: TextButton(
                      onPressed: _saveChanges,
                      child: Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
