import 'package:flutter/material.dart';

String username = "";
String email = "";
String catName = "";

const secondaryColor = Color(0xFF8B94BC);
const greenColor = Color(0xFF6AC259);
const darkGreenColor = Color(0xFF003806);
const redColor = Color(0xFFE92E30);
const grayColor = Color(0xFFC1C1C1);
const blackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;

class CustomStyle {
  static TextStyle blackheadline6(BuildContext context) {
    return Theme.of(context).textTheme.headline6.copyWith(color: Colors.black);
  }

  static TextStyle pinkheadline6(BuildContext context) {
    return Theme.of(context).textTheme.headline6.copyWith(color: Colors.pink);
  }

  static TextStyle blacksubtitle1(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black);
  }

  static TextStyle blacksubtitle2(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.black);
  }

  static TextStyle whiteheadline5(BuildContext context) {
    return Theme.of(context).textTheme.headline5.copyWith(color: Colors.white);
  }

  static TextStyle blackboldheadline5(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        .copyWith(color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle pinkboldheadline5(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        .copyWith(color: Colors.pink, fontWeight: FontWeight.bold);
  }

  static TextStyle whiteboldheadline4(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle greenboldheadline5(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        .copyWith(color: Colors.green, fontWeight: FontWeight.bold);
  }

  static TextStyle redboldheadline5(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headline5
        .copyWith(color: Colors.red, fontWeight: FontWeight.bold);
  }
}
