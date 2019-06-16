import 'package:flutter/material.dart';
import 'package:memecon/settings_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
          ])),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.of(context).pushNamed(SettingsPage.tag);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
