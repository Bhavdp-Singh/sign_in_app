import 'package:flutter/material.dart';
import 'package:sign_in_app/utils/UIChallenge1.dart';
import 'package:sign_in_app/widgets/textField.dart';
import 'package:toast/toast.dart';
import 'Login/Welcome_Page.dart';
import 'Login/backgroundWaveButton.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  Color color = Colors.green;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
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
                          Text(
                            "Hi",
                            style: TextStyle(
                              fontSize: 50.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          ),
                          Text(
                            "Sign Up to continue",
                            style: TextStyle(
                              //decoration: TextDecoration.none,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 10,),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5,),
                                    child: TextField(
                                        keyboardType: TextInputType
                                            .emailAddress,
                                        controller: _nameController,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          if (value == '') {
                                            setState(() {
                                              color = Colors.blue;
                                              errorText = '';
                                            });
                                          }
                                          else {
                                            final DocumentReference documentReference =
                                            Firestore.instance.document(
                                                "UserNamee/$value");
                                            documentReference.snapshots()
                                                .listen((datasnapshot) {
                                              //FINDING A SPECIFICDOCUMENT IS EXISTING INSIDE A COLLECTION


                                              if (datasnapshot.exists) {
                                                setState(() {
                                                  color = Colors
                                                      .red;
                                                  errorText =
                                                  'Username already exist';
                                                });
                                              } else if (!datasnapshot.exists) {
                                                setState(() {
                                                  color = Colors.blue;
                                                  errorText =
                                                  'Username available';
                                                });
                                                print('F');
                                              }
                                            }

                                            );
                                          }
                                        },

                                        decoration: InputDecoration(
                                            helperStyle: TextStyle(
                                                color: color
                                            ),
                                            helperText: errorText,

                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  25.0),
                                            ),
                                            labelStyle: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                            ),
                                            hintText: "Username",
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  5.0),
                                            ))
                                    ),
                                  ),

                                  UITextField(controller:_emailController,hintText: "Email",),
                                  UITextField(controller: _passwordController,  hintText: "Password",hideText: true,)
                                ],
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: signUpSubmit,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.88,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      "Submit",
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
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          BackgroundWaveButton(
              width: _screenWidth, height: _screenHeight, text: 'Sign In')
        ],
      ),
    );
  }


  void navigate() {
    // oute t = SlideUpRoute(page: LoginPage());
    Route route = MaterialPageRoute(
        builder: (context) => WelcomePage(name: _nameController.text));
    Navigator.of(context).push(route);
  }

  void Write() {
    Firestore.instance.collection('books').document()
        .setData({ 'title': 'title', 'author': 'author'});
  }

 void signUpSubmit() {
    if (_formKey.currentState.validate()) {
      auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text).then((data) {
        firestore.collection(UIChallenge.collectionAllUser).document(data.user.uid).setData(
            {
              'Username': _nameController.text,
              'Email': _emailController.text,
              'Password': _passwordController.text,
              'Uid': data.user.uid
            }
        ).catchError((onError) {
          print(onError.message.toString());
        }).then((h) {
          firestore.collection('UserNamee').document(_nameController.text).setData({});
          navigate();
          print('done');
        });
      }).catchError((onError){
        Toast.show(onError.message.toString(), context);
        print(onError.message.toString());
      });
    }
  }
}