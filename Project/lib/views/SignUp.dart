import 'package:flutter/material.dart';
import 'package:project/Models/users.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/WelcomScreen.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final hint = TextEditingController();

  bool isVisible = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text('Register New Account',style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.5)
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'username is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: 'User Name'
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.5)
                    ),
                    child: TextFormField(
                      controller: email,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Email is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'Email'
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.5)
                    ),
                    child: TextFormField(
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'password is required';
                        }
                        return null;
                      },
                      obscureText: isVisible,
                      decoration:  InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            isVisible = !isVisible;
                          });
                        }, icon: Icon(isVisible ?Icons.visibility_off: Icons.visibility)),


                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(.5)
                    ),
                    child: TextFormField(
                      controller: hint,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Hint  is required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.question_mark),
                          border: InputBorder.none,
                          hintText: 'Hint'
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),


                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width *.9,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: TextButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                            final db  = DatabaseHelper();
                            Users user = Users(userName: username.text, password: password.text);
                            user.email = email.text;
                            user.hint = hint.text;
                            db.signUp(user).whenComplete(() =>
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginApp())),

                            );
                      }
                    }, child: Text('SIGN UP',style: const TextStyle(color: Colors.black),)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already Have an account?"),
                      TextButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginApp()));
                      }, child: Text("SIGN IN")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
