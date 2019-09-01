import 'package:flutter/material.dart';
class BackgroundWave1 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0.0, size.height/4);

    var firstControlPoint= new Offset(0 ,-height/4);
    var secondControlPoint = new Offset(0.4 * width , height/2);
    var thirdControlPoint = new Offset(0.6 * width, height/2);
    var fourthControlPoint = new Offset(width , -height/4);

    var firstEndPoint = new Offset(width * 0.2,height /6);
    var secondEndPoint = new Offset(width/2 , 0);
    var thirdEndPoint = new Offset( width*.8 , height/6);
    var fourthEndPoint = new Offset(width , height/4);

    path.quadraticBezierTo( firstControlPoint.dx, firstControlPoint.dy,firstEndPoint.dx,firstEndPoint.dy);
    path.quadraticBezierTo( secondControlPoint.dx,secondControlPoint.dy,secondEndPoint.dx,secondEndPoint.dy);
    path.quadraticBezierTo( thirdControlPoint.dx, thirdControlPoint.dy,thirdEndPoint.dx,thirdEndPoint.dy);
    path.quadraticBezierTo( fourthControlPoint.dx, fourthControlPoint.dy,fourthEndPoint.dx,fourthEndPoint.dy);
    path.lineTo(width,height);
    path.lineTo(0.0,height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}
class BackgroundWave2 extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0.0, size.height/2);
    var firstControlPoint= new Offset(0 ,height/8);
    var secondControlPoint = new Offset(0.4 * width , height/3);
    var thirdControlPoint = new Offset(0.6 * width, height/3);
    var fourthControlPoint = new Offset(width , height/8);

    var firstEndPoint = new Offset(size.width * 0.2,height /3.5);
    var secondEndPoint = new Offset(width/2 , 0);
    var thirdEndPoint = new Offset(0.8 * width , height /3);
    var fourthEndPoint = new Offset(width , height/2);

    path.quadraticBezierTo( firstControlPoint.dx, firstControlPoint.dy,firstEndPoint.dx,firstEndPoint.dy);
    path.quadraticBezierTo( secondControlPoint.dx,secondControlPoint.dy,secondEndPoint.dx,secondEndPoint.dy);
    path.quadraticBezierTo( thirdControlPoint.dx, thirdControlPoint.dy,thirdEndPoint.dx,thirdEndPoint.dy);
    path.quadraticBezierTo( fourthControlPoint.dx, fourthControlPoint.dy,fourthEndPoint.dx,fourthEndPoint.dy);
    path.lineTo(width,height);
    path.lineTo(0.0,height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}

