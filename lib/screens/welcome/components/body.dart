import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/screens/welcome/components/background.dart';
import 'package:meditime/components/rounded_Button.dart';
import 'package:meditime/screens/login/loginScreen.dart';
import 'package:meditime/base/userTypeEnums.dart';

import 'package:meditime/notifications/notifications.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          RoundedButton(
            text: "Patient Login/SignUp",
            color: Color(0xff616e7d),
            textColor: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(UserTypeE.patient),
                ),
              );
            }
          ),
          RoundedButton(
            text: "Doctor Login/SinUp",
            color: Colors.white60,
            textColor: Colors.black,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(UserTypeE.doctor),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}