import 'dart:ui';
import 'package:flutter/material.dart';

const MaterialColor myColor = const MaterialColor(
  0xff0170C1,
  const <int, Color>{
    50: const Color(0xff0170C1),
    100: const Color(0xff004690),
    500: const Color(0xffF26E68),
  },
);

final ThemeData themeData = ThemeData(
// Define the default Brightness and Colors
  brightness: Brightness.light,
  primaryColor: myColor[50],
  accentColor: myColor[500],

// Define the default Font Family
  fontFamily: 'Montserrat',

// Define the default TextTheme. Use this to specify the default
// text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);
