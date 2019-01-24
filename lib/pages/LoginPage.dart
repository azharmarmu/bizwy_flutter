import 'package:bizwy_flutter/sql_model/LoginModel.dart';
import 'package:bizwy_flutter/pages/LandingPage.dart';
import 'package:bizwy_flutter/presenter/LoginPresenter.dart';
import 'package:bizwy_flutter/utils/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPresenter loginPresenter;
  List<LoginModel> data;

  bool loggedIn = true;
  Widget bodyProgress = Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();
    loginPresenter = new LoginPresenter();
    getUserData();
  }

  Future getUserData() async {
    data = await loginPresenter.getUser();
    if (data != null) {
      if (data.length > 0) {
        landingWidget(context);
      } else {
        setState(() {
          loggedIn = false;
        });
      }
    } else {
      setState(() {
        loggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/app_icon.png'),
      ),
    );

    final phone = TextFormField(
      maxLength: 10,
      keyboardType: TextInputType.phone,
      autofocus: false,
      controller: phoneController,
      decoration: InputDecoration(
        hintText: 'Mobile Number',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => fetchLogin(context),
        padding: EdgeInsets.all(12),
        color: Theme.myColor[50],
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () => fetchLogin(context),
    );

    final bodyWidget = Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          logo,
          SizedBox(height: 48.0),
          phone,
          SizedBox(height: 8.0),
          password,
          SizedBox(height: 24.0),
          loginButton,
          forgotLabel
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: loggedIn ? bodyProgress : bodyWidget,
    );
  }

  static const platform = const MethodChannel('flutter.bizwy.com.channel');

  fetchLogin(BuildContext context) async {
    try {
      Map<String, String> map = {};
      map['user_mobile'] = phoneController.text;
      map['user_pin'] = passwordController.text;
      map['key_fcm'] =
          "d6h2JWBW7Zo:APA91bGZlA91GtRR2dltssklA-Iv_sWTUVwD1xrByxwnkuzsFG87s5P71Y17Ugta740DP0Xs723EV0t_6PH8K8Gw3Ru8epILETfpG4D8QwMXIoOy5GsCKCjg8UApYu2Fu7VrbJPAlGbf";

      final String encrypted = await platform
          .invokeMethod('getEncryptedValue', {"input": convert.jsonEncode(map)});

      final response =
          await http.post(Api.loginApi, body: {'json_data': encrypted});

      if (response.statusCode == 200) {
        Map jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['error_flag'] == false) {
          LoginModel loginModel = new LoginModel.map(jsonResponse['data']);
          LoginPresenter()
              .addUser(loginModel)
              .then((res) => landingWidget(context))
              .catchError((onError) => print(onError.toString()));
        }
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      print(e);
    }
  }

  landingWidget(BuildContext context) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
      ModalRoute.withName('/'),
    );
  }
}
