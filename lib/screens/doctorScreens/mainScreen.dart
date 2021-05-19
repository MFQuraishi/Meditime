import 'package:flutter/material.dart';
import 'package:meditime/screens/doctorScreens/components/body.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("logged in as Doctor"),
      ),
      body: Body(),
    );
  }
}