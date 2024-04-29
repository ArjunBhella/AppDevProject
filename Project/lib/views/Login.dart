import 'package:flutter/material.dart';
import 'package:project/Models/users.dart';
import 'package:project/SQLite/sqlite.dart';
import 'package:project/views/SignUp.dart';
import 'package:project/views/WelcomScreen.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  login() async{
    var response = await db.login(Users(userName: username.text, password: password.text));
    if(response == true){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen(username: username.text)));

    }
    else{
      setState(() {
        isLoginTrue  = true;
      });
    }
  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('Welcome to ImmuniDose!',style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),

                SizedBox(height: 40,),

                Image.asset('assets/logo.png'),
                const SizedBox(height: 15,),
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
                      hintText: 'UserName'
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
            
                SizedBox(height: 10,),
                
                
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width *.9,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                  ),
                  child: TextButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                          login();
                      }
                  }, child: Text('LOGIN',style: const TextStyle(color: Colors.black),)),
                ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have an account?"),
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUp()));
                    }, child: Text("SIGN UP")),
                  ],
                ),

                isLoginTrue? const Text('Username or password is incorect',style: TextStyle(
                  color: Colors.red
                ),): const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
