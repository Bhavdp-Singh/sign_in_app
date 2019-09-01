import 'package:flutter/material.dart';
import 'package:sign_in_app/Login/login_page.dart';
import 'package:sign_in_app/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth= FirebaseAuth.instance;
final firestore= Firestore.instance;
void main() {

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
