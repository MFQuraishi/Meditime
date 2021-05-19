import "package:flutter/material.dart";
import "package:meditime/screens/login/components/body.dart";

class LoginScreen extends StatelessWidget{
  var userType;

  LoginScreen(this.userType);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Body(userType),
      );
  }
}