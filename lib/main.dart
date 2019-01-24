import 'package:bizwy_flutter/pages/LandingPage.dart';
import 'package:bizwy_flutter/pages/LoginPage.dart';
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bizwy Demo',
      theme: Theme.themeData,
      home: LoginPage(),
    );
  }
}
