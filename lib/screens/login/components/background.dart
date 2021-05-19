import 'package:flutter/material.dart';

class Background extends StatelessWidget{
  final Widget child;
  Background({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children:<Widget>[
          Positioned(
            bottom: -200,
            right: -200,
            child: Image.asset(
              "assets/images/clock.png",
              width: size.width * 0.8,
            ),
          ),
          Positioned(
            top: -250,
            left: -240,
            child: Image.asset(
              "assets/images/clock.png",
              width: size.width,
            ),
          ),
          child,
        ],
      ),
    );
  }
}