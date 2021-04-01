import "package:flutter/material.dart";
import "package:meditime/constants.dart";

class RoundedButton extends StatelessWidget{

  final String text;
  final Function press;
  final color,textColor;

  const RoundedButton({
        Key key,
        this.text,
        this.press,
        this.color,
        this.textColor,
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: SizedBox(
            height: 50,
            child: TextButton(
              child: Text(this.text),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(this.color),
                foregroundColor: MaterialStateProperty.all<Color>(this.textColor),
                //overlayColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: press,
            ),
          ),
        ),
      ),
    );
  }
}
