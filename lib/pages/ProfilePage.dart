import 'package:bizwy_flutter/utils/Strings.dart';
import 'package:bizwy_flutter/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loaded = true;

  @override
  Widget build(BuildContext context) {
    final bodyWidget = Stack(
      children: <Widget>[
        Container(
          height: 160.0,
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/maxresdefault.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(16, 60, 16, 16),
          height: 250.0,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 48.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.feedback,
                        size: 20.0,
                        color: Theme.myColor[50],
                      ),
                      Text(
                        'Azhar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                  Text('Azhar'),
                  Text('Azhar'),
                ],
              ),
            ),
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MyAppBar(title: Strings.profile,appBarType: 1,),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Strings.profilePageMenu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: !loaded ? Center(child: CircularProgressIndicator()) : bodyWidget,
    );
  }

  choiceAction(String value) {
    if (value == Strings.tag_management) {
      print(value);
    } else if (value == Strings.edit) {
      print(value);
    } else if (value == Strings.notes) {
      print(value);
    }
  }
}
