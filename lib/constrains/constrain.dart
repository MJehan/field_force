import 'package:flutter/material.dart';

class AppColor{
  static const kTextColor = Color(0xFF1E2432);
  static const kTextMediumColor = Color(0xFF53627C);
  static const kTextLightColor = Color(0xFFACB1C0);
  static const kPrimaryColor = Color(0xFF0D8E53);
  static const kBackgroundColor = Color(0xFFFCFCFC);
  static const kInactiveColor = Color(0xFFEAECEF);
  static const kConfirmedColor = Color(0xFFFF9C00);
  static const kDeathColor = Color(0xFFFF2D55);
  static const kRecoverdColor = Color(0xFF50E3C2);
  static const kNewCase =  Color(0xFF5856d6);
}

const optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
