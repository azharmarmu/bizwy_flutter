import 'dart:io';

import 'package:bizwy_flutter/model/LoginModel.dart';
import 'package:bizwy_flutter/pages/LoginPage.dart';
import 'package:bizwy_flutter/presenter/LoginPresenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  LoginPresenter loginPresenter;
  List<LoginModel> data;

  @override
  void initState() {
    super.initState();
    loginPresenter = new LoginPresenter();
    getUserData();
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.center;

    return new InkWell(
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text(
              'User Database',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),
      body: new Container(
        color: Colors.green,
        child: Text('Landing Page'),
      ),
    );
  }

  loginWidget(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Future getUserData() async {
    data = await loginPresenter.getUser();
    if (data.length <= 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}
