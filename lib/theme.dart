import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    // primarySwatch: Colors.blue,
    primaryColor: Colors.black,
    // accentColor: Colors.blue[600],
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    ));

ThemeData dark = ThemeData(
    // brightness: Brightness.dark,
    // primarySwatch: Colors.blue,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color.fromRGBO(43, 10, 69, 0.35),
    colorScheme: const ColorScheme.dark(),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    )
    // scaffoldBackgroundColor: const Color.fromRGBO(2, 245, 120, 0.2)
    // scaffoldBackgroundColor: Colors.redAccent,
    );

class CustomTheme {
  CustomTheme();

  static const Color loginGradientStart = Color(0xFF00BCD4);
  static const Color loginGradientEnd = Color(0xFF43AF50);

  // original colors
  //   static const Color loginGradientStart = Color(0xFFfbab66);
  // static const Color loginGradientEnd = Color(0xFFf7418c);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
