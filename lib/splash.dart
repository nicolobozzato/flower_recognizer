import 'package:dog_cat_recognizer/home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: Home(),
      title: Text('Dog Cat Recognizer',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue)),
      image: Image.asset('assets/cat.png'),
      backgroundColor: Colors.black,
      photoSize: 50,
      loaderColor: Colors.blue,
    );
  }
}
