import 'package:bizwy_flutter/utils/Api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

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
        color: Colors.lightBlueAccent,
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

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
      ),
    );
  }

  static const platform = const MethodChannel('flutter.bizwy.com.channel');

  fetchLogin(BuildContext context) async {
    try {
      Map<String, String> params = new Map();

      final json = {};

      json['user_mobile'] = phoneController.text;
      json['user_pin'] = passwordController.text;
      json['key_fcm'] = 'hfdaobadjcjolb';

      print('JSON:' + json.toString());

      final String encrypted = await platform
          .invokeMethod('getEncryptedValue()', {"input": json.toString()});
      print('Encrypted JSON:$encrypted%.');

      params['json_data'] = encrypted;

      print(params.toString());
      final response = await http.post(Api.loginApi, body: params);

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse.toString());
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } catch (e) {
      print(e);
    }
  }
}
