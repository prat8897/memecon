import 'package:flutter/material.dart';
import 'package:memecon/login_page.dart';
import 'package:memecon/home_page.dart';
import 'package:memecon/settings_page.dart';
import 'package:memecon/pageview_screen.dart';
import 'package:memecon/Services/auth_flow.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {

  SystemChrome.setEnabledSystemUIOverlays([]);

  final storage = new FlutterSecureStorage();

  await storage.read(key: "credentialsJSON").then(
    (redditCredentialsJSON) {
      print("ATTENTION JSON STORAGE is " + redditCredentialsJSON.toString());
      if (redditCredentialsJSON == null){
        runApp(MyApp(defaultHome: LoginPage(),));
      } else {
        restoreRedditUser(redditCredentialsJSON);
        runApp(MyApp(defaultHome: HomePage(),));
      }
    }
  );
}

class MyApp extends StatelessWidget {
  final Widget defaultHome;

  MyApp({
    Key key,
    @required this.defaultHome,
  }) : super(key: key);

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
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
