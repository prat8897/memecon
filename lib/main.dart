import 'package:flutter/material.dart';
import 'package:memecon/login_page.dart';
import 'package:memecon/home_page.dart';
import 'package:memecon/settings_page.dart';
import 'package:memecon/pageview_screen.dart';
import 'package:memecon/Services/auth_flow.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  //Hide Status Bar
  SystemChrome.setEnabledSystemUIOverlays([]);

  //Flutter Secure Storage to save reddit credentials
  //https://github.com/mogol/flutter_secure_storage

  final storage = new FlutterSecureStorage();

  //await storage.delete(key: "credentialsJSON");

  await storage.read(key: "credentialsJSON").then((redditCredentialsJSON) {
    print("ATTENTION JSON STORAGE IS " + redditCredentialsJSON.toString());
    if (redditCredentialsJSON == null) {
      runApp(MyApp(
        defaultHome: LoginPage(),
      ));
    } else {
      restoreRedditUser(redditCredentialsJSON).then((reddit) {
        runApp(MyApp(
          defaultHome: HomePage(
            reddit: reddit,
          ),
        ));
      });
    }
  });
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  MyApp({
    Key key,
    @required this.defaultHome,
  }) : super(key: key);

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(reddit: null,),
    SettingsPage.tag: (context) => SettingsPage(),
    PageViewScreen.tag: (context) => PageViewScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memecon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Nunito',
      ),
      home: defaultHome,
      routes: routes,
    );
  }
}
