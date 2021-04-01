import 'package:flutter/material.dart';
import 'package:meditime/screens/welcome/welcome_screen.dart';
import 'package:meditime/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'meditime',
      theme: ThemeData(
        primaryColor: meditimePrimary,
        scaffoldBackgroundColor: meditimeLightColor
      ),
      home: WelcomeScreen(),
    );
  }
}

