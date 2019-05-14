import 'package:flutter/material.dart';
import 'package:memecon/login_page.dart';
import 'package:memecon/home_page.dart';
import 'package:memecon/settings_page.dart';
import 'package:memecon/pageview_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    HomePage.tag: (context) => HomePage(),
    SettingsPage.tag: (context) => SettingsPage(),
    PageViewScreen.tag: (context) => PageViewScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
