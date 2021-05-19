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
            bottom: -100,
            right: -100,
            child: Image.asset(
              "assets/images/clock.png",
              width: size.width * 0.8,
            ),
          ),
          Positioned(
            top: -150,
            left: -140,
            child: Image.asset(
              "assets/images/clock.png",
              width: size.width,
            ),
          ),



          Positioned(
            top: 60,
            right: 60,
            child: Transform.rotate(
              angle: 200,
              child: Image.asset(
                "assets/images/tablet.png",
                width: size.width * 0.2,
              ),
            ),
          ),

          Positioned(
            top: 180,
            right: 90,
            child: Transform.rotate(
              angle: 120,
              child: Image.asset(
                "assets/images/pill.png",
                width: size.width * 0.07,
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 30,
            child: Transform.rotate(
              angle: 270,
              child: Image.asset(
                "assets/images/tablet_bottle.png",
                width: size.width * 0.3,
              ),
            ),
          ),

          Positioned(
            bottom: 190,
            left: 50,
            child: Transform.rotate(
              angle: 300,
              child: Image.asset(
                "assets/images/tablet.png",
                width: size.width * 0.18,
              ),
            ),
          ),

          Positioned(
            bottom: 190,
            right: 70,
            child: Transform.rotate(
              angle: 40,
              child: Image.asset(
                "assets/images/pill.png",
                width: size.width * 0.1,
              ),
            ),
          ),

          Positioned(
            top: 220,
            left: 30,
            child: Transform.rotate(
              angle: 270,
              child: Image.asset(
                "assets/images/tablet.png",
                width: size.width * 0.15,
              ),
            ),
          ),






          child,
        ],
      ),
    );
  }
}