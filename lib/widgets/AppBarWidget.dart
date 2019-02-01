import 'dart:io';

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final int appBarType;

  const MyAppBar(
      {Key key, this.title, this.appBarType})
      : assert(title != null),
        assert(appBarType != null);

  @override
  Widget build(BuildContext context) {
    var horizontalTitleAlignment =
    Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    Widget appBar;

    switch (appBarType) {
      case 1:
        appBar = InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: horizontalTitleAlignment,
              children: <Widget>[
                Text(
                  title,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case 2:
        break;
    }

    return appBar;
  }
}
