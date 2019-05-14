import 'package:flutter/material.dart';
import 'package:memecon/settings_page.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List <String> imgurlinks = [
    'https://i.imgur.com/6hhWdTB.jpg',
    'https://i.imgur.com/3qEXYZT.jpg',
    'https://i.imgur.com/ubYYBBd.jpg',
    'https://i.imgur.com/RvtTFv1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    var leftdrawer = Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
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
              ]
            )
          ),
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
    
    Widget buildimagecard(link){
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(PageViewScreen.tag);
        },
        child: Image.network(link),
      );
    }

    final body = GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children: <Widget>[
        for (var link in imgurlinks) buildimagecard(link)
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: leftdrawer,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        centerTitle: true,
        title: Text("/r/MemeEconomy"),
      ),
      body: body,
    );
  }
}
