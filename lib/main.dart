import 'package:flutter/material.dart';
import 'package:meditime/screens/welcome/welcome_screen.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/notifications/notifications.dart';

Future<void> main()async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Notifications().init();
  runApp(MyApp());
}

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

