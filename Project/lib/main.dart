import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'views/Login.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      home: const LoginApp(),
    );
  }
}







