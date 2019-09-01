import 'package:flutter/material.dart';

class UITextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool hideText;
  const UITextField({Key key, this.hintText, this.controller,  this.hideText=false}) : super(key: key);
  @override
  _UITextFieldState createState() => _UITextFieldState();
}

class _UITextFieldState extends State<UITextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20, vertical: 5),
      child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.emailAddress,
          controller: widget.controller,
          textAlign: TextAlign.center,
          validator: (String value) {
            if (value.isEmpty) {
              return "Field cannot be empty";
            }
          },
          obscureText: widget.hideText,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2.0),
                borderRadius:
                BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2.0),
                borderRadius:
                BorderRadius.circular(25.0),
              ),
              labelStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(5.0),
              ))),
    );
  }
}
