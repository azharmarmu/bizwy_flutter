import 'package:bizwy_flutter/pages/CustomerPage.dart';
import 'package:bizwy_flutter/pages/LoginPage.dart';
import 'package:bizwy_flutter/pages/ProfilePage.dart';
import 'package:bizwy_flutter/widgets/CircleButtonWidget.dart';
import 'package:bizwy_flutter/widgets/AppBarWidget.dart';
import 'package:bizwy_flutter/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bizwy_flutter/utils/Theme.dart' as Theme;

class LandingPage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Fragment 1", Icons.rss_feed),
    new DrawerItem("Fragment 2", Icons.local_pizza),
    new DrawerItem("Fragment 3", Icons.info)
  ];

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return landingWidget(context);
      case 1:
        return landingWidget(context);
      case 2:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(
          title: 'Marmu',
          appBarType: 1,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Strings.landingPageMenu.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("John Doe"),
              accountEmail: new Text("8072223041"),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: Theme.myColor[500],
      ),
    );
  }

  loginWidget(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  landingWidget(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleButton(
                onTap: () => print(Strings.catalogue),
                iconData: Icons.call_to_action,
                iconText: Strings.catalogue,
              ),
              SizedBox(height: 48.0),
              CircleButton(
                onTap: () => print(Strings.feedback),
                iconData: Icons.feedback,
                iconText: Strings.feedback,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleButton(
                onTap: () => print(Strings.executive),
                iconData: Icons.person_outline,
                iconText: Strings.executive,
              ),
              SizedBox(height: 48.0),
              CircleButton(
                onTap: () => print(Strings.app_name),
                iconData: Icons.graphic_eq,
                size: 100.0,
              ),
              SizedBox(height: 48.0),
              CircleButton(
                onTap: () => print(Strings.order_billing),
                iconData: Icons.border_color,
                iconText: Strings.order_billing,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleButton(
                onTap: () => print(Strings.stock),
                iconData: Icons.show_chart,
                iconText: Strings.stock,
              ),
              SizedBox(height: 48.0),
              CircleButton(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerPage())),
                iconData: Icons.people,
                iconText: Strings.customer,
              ),
            ],
          ),
        ],
      ),
    );
  }

  choiceAction(String value) {
    if (value == Strings.profile) {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else if (value == Strings.change_pin) {
      print(value);
    } else if (value == Strings.change_language) {
      print(value);
    }
  }
}

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}
