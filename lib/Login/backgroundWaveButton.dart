import 'package:flutter/material.dart';
import 'package:sign_in_app/Common/Backgrounds.dart';
import 'package:sign_in_app/Common/SlideTransitions.dart';
import '../sign_up.dart';
import 'login_page.dart';

class BackgroundWaveButton extends StatefulWidget {
  final double height,width;
  final String text;
  const BackgroundWaveButton({Key key, this.height, this.width,  this.text}) : super(key: key);
  @override
  _BackgroundWaveButtonState createState() => _BackgroundWaveButtonState();
}

class _BackgroundWaveButtonState extends State<BackgroundWaveButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: 60,
            width: widget.width,
            child: ClipPath(
                clipper: BackgroundWave2(),
                child: Container(
                  height: 60,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.orange.withOpacity(0.7),
                )),
          ),
          Container(
            height: 60,
            width: widget.width,
            child: ClipPath(
              clipper: BackgroundWave1(),
              child: Container(
                height: 60,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.pink.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
              bottom: 25,
              left: widget.width / 2 - 20,
              child: GestureDetector(
                onVerticalDragUpdate: (data){
                  print('sd sdb');
                  widget.text=="Sign In"?_login():widget.text=="Sign Up"?_signUp():null;
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.keyboard_arrow_up),
                ),
              )),
          Positioned(
            bottom: 5,
            left: widget.width / 2 - 40,
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ),
        ],
      ),
    );
  }

  void _signUp() {
    Route t = SlideUpRoute(page: SignUpPage());
    Route route = MaterialPageRoute(builder: (context) => SignUpPage());
    Navigator.of(context).push(t);
  }
    void _login() {
      Route t = SlideUpRoute(page: LoginPage());
      Route route = MaterialPageRoute(builder: (context) => LoginPage());
      Navigator.of(context).push(t);
    }
  }
