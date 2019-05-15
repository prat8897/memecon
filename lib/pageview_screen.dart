import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  static String tag = 'pageview-screen';
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {

  List <String> imgurlinks = [
    'https://i.imgur.com/6hhWdTB.jpg',
    'https://i.imgur.com/3qEXYZT.jpg',
    'https://i.imgur.com/ubYYBBd.jpg',
    'https://i.imgur.com/RvtTFv1.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {

    Widget _buildPageView(context, position) {
      return Image.network('https://i.imgur.com/6hhWdTB.jpg');
    }

    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, position) {
          print("CONTEXT: " + context.toString());
          print("POSITION: " + position.toString());
          return _buildPageView(context, position);
        },
      )
    );
  }
}