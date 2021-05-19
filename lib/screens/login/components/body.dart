import 'package:flutter/material.dart';
import 'package:meditime/base/userTypeEnums.dart';
import 'package:meditime/components/inputContainer.dart';
import 'package:meditime/components/rounded_Button.dart';
import 'package:meditime/screens/login/components/background.dart';
import 'package:meditime/constants.dart';
import 'package:meditime/services/toastServices.dart';
import 'package:meditime/screens/patientScreens/mainScreen.dart' as patientLogin;
import 'package:meditime/screens/doctorScreens/mainScreen.dart'as doctorLogin;

import 'package:meditime/components/inputContainer.dart';

class Body extends StatelessWidget {
  var userType;
  Map userCredentials = {"userType": "", "username": "", "password": ""};
  Body(this.userType);

  Widget username() {
    return InputContainer(
      child: TextField(
        autofocus: false,
        cursorColor: meditimePrimary,
        decoration: InputDecoration(
          icon: Icon(
            Icons.person,
            color: meditimePrimary,
          ),
          border: InputBorder.none,
          hintText: "Username",
        ),
        onChanged: (text) {
          userCredentials["username"] = text;
        },
      ),
    );
  }

  Widget password() {
    return InputContainer(
      child: TextField(
        cursorColor: meditimePrimary,
        decoration: InputDecoration(
          icon: Icon(
            Icons.security,
            color: meditimePrimary,
          ),
          hintText: "Password",
          border: InputBorder.none,
        ),
        obscureText: true,
        onChanged: (text) {
          userCredentials["password"] = text;
        },
      ),
    );
  }

  Widget registerTextButton() {
    return TextButton(
      onPressed: () => {},
      child: Text("Not yet Registered? SignUp"),
    );
  }

  Widget image(size) {
    return userType == UserTypeE.patient
        ? Container(
            child: Image.asset("assets/images/doctor_patient_matched.png"),
          )
        : Container(
            child: Image.asset("assets/images/doctor_full_matched.png"),
            height: size.width * 0.8,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image(size),
            username(),
            password(),
            RoundedButton(
              color: meditimePrimary,
              text: "Login",
              textColor: Colors.white,
              press: () { //temporary implementaion of toast for hardcoded login
                userCredentials["userType"] =
                    (userType == UserTypeE.patient) ? "patient" : "doctor";

                print(userCredentials);
                bool isInvalid = true;
                if(userCredentials["username"].length > 0){
                  if(userCredentials["username"] == "p" && userCredentials["password"] == "p" && userCredentials["userType"] == "patient"){
                    ToastServices.defaultToast("Logging in as " + userCredentials["userType"]);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => patientLogin.MainScreen(),)
                    );
                    isInvalid = false;
                  }
                  else if(userCredentials["username"] == "d" && userCredentials["password"] == "d" && userCredentials["userType"] == "doctor"){
                    ToastServices.defaultToast("Logging in as " + userCredentials["userType"]);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => doctorLogin.MainScreen(),
                      )
                    );
                    isInvalid = false;
                  }
                }
                if(isInvalid){
                  ToastServices.defaultToast("Username or Password is Invalid");
                }
              },
            ),
            registerTextButton(),
          ],
        ),
      ),
    );
  }
}