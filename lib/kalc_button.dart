import 'package:flutter/material.dart';

Widget kalcButton(
    String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    width: 90,
    height: 90,
    padding: const EdgeInsets.all(0),
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius:BorderRadius.all(Radius.circular(20))),
          backgroundColor: buttonColor),
      child: Text(buttonText,
        style: const TextStyle(fontSize: 50, color: Colors.white),
      ),
    ),
  );
}