import 'package:flutter/material.dart';

import '../constants.dart';

class NumberpadButton extends StatelessWidget {
  NumberpadButton({super.key, required this.buttonText});

  String buttonText;
  Color buttonColor = yellowColor;
  Color textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    if (buttonText == 'DEL') {
      buttonColor = Colors.red;
      textColor = Colors.white;
    } else if (buttonText == 'Check') {
      buttonColor = Colors.black;
      textColor = Colors.white;
    }
    return Container(
      margin: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: buttonColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(5, 5),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-1, -1),
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Center(
          child: Text(
        buttonText,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: textColor),
      )),
    );
  }
}
