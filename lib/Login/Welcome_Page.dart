import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({this.name});
  final String name;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.deepPurpleAccent,
        child: Center(child: Text("Welcome "+ widget.name)),
      )
    );
  }
}
