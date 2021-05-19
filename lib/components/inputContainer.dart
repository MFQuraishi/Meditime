import 'package:flutter/material.dart';
import 'package:meditime/constants.dart';

class InputContainer extends StatelessWidget {
  final Widget child;
  InputContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(30),
      ),
      child: this.child,
    );
  }
}
