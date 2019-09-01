import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_app/utils/UIChallenge1.dart';
import 'package:sign_in_app/widgets/textField.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import '../main.dart';
import 'Welcome_Page.dart';
import 'backgroundWaveButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fKMainForm = GlobalKey<FormState>();
  final _fKForgotPassword = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Scaffold(
            key: _scaffold,
            resizeToAvoidBottomPadding: false,
            body: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: ListView(
                children: <Widget>[
                  Builder(builder: (context) {
                    return Container(
                      height: _screenHeight,
                      width: _screenWidth,
                      color: Colors.deepPurpleAccent,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: _screenWidth / 3),
                          ),
                          // Hi Text
                          Text(
                            "Hi",
                            style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          // Text
                          Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Form(
                            key: _fKMainForm,
                            child: Column(
                              children: <Widget>[
                                // Email TextField
                                UITextField(hintText: 'Email',controller: _emailController,),
                                //  Password TextField
                                UITextField(hintText: 'Password',controller: _passwordController,hideText: true),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _login,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10, color: Colors.grey)
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.88,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                _showDialog(context);
                              },
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Forgot Password ?",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          BackgroundWaveButton(
            width: _screenWidth,
            height: _screenHeight,
            text: 'Sign Up',
          )
        ],
      ),
    );
  }

  void navigate(data) {
    // route t = SlideUpRoute(page: LoginPage());
    Route route =
        MaterialPageRoute(builder: (context) => WelcomePage(name: data));
    Navigator.of(context).push(route);
  }

  void _showDialog(BuildContext context) {
    // flutter defined function

    showDialog(
        context: context,
        builder: (builder) {
          // return object of type Dialog

          return AlertDialog(
            title: new Text("Recover Password"),
            content: Container(
              width: 100,
              height: 50,
              child: Form(
                key: _fKForgotPassword,
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "please enter email";
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurpleAccent, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurpleAccent, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        hintText: "email",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog

              Row(
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("Submit",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      resetPassword(_emailController.text);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  new RaisedButton(
                    color: Colors.white,
                    child: new Text("Cancel",
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }


  void _login() async {
    if (_fKMainForm.currentState.validate()) {
      AuthResult authResult;
      authResult = await auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text)
                             .catchError((onError) async {
        Toast.show(onError.message.toString(), context); // Showing Error Text
        if (authResult.user != null) {
          final QuerySnapshot result = await Firestore.instance
              .collection(UIChallenge.collectionAllUser)
              .where('Uid', isEqualTo: authResult.user.uid)
              .getDocuments();
          final List<DocumentSnapshot> data = result.documents;
          navigate(data[0]['Username']);
        }
        print('done');
      });
    }
  }
}
