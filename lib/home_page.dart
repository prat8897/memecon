import 'dart:async';

import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:memecon/settings_page.dart';
import 'package:memecon/pageview_screen.dart';
import 'package:memecon/Services/auth_flow.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  final Reddit reddit;

  HomePage({
    Key key,
    @required this.reddit,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  List<Submission> submissions = [];

  @override
  void initState() {
    super.initState();
  }

  List<String> imgurlinks = [
    'https://i.imgur.com/6hhWdTB.jpg',
    'https://i.imgur.com/3qEXYZT.jpg',
    'https://i.imgur.com/ubYYBBd.jpg',
    'https://i.imgur.com/RvtTFv1.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    final body = Center(
      child: StreamBuilder<Submission>(
        stream: widget.reddit.subreddit('MemeEconomy')
            .hot()
            .map((content) => content as Submission),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            submissions.add(snapshot.data);

            return GridView.builder(
              itemCount: submissions.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                /*
                PostView newPostView = PostView(
                    key: ValueKey<String>(submissions.elementAt(index).id),
                    post: Post(submission: submissions.elementAt(index))
                );
                */

                return InkWell(
                  onTap: () =>
                    Navigator.of(context).pushNamed(PageViewScreen.tag),
                  child: Image.network(submissions.elementAt(index).thumbnail.toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.red,
            );
          } else {
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.teal),
            );
          }
        }
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: new LeftDrawer(),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        centerTitle: true,
        title: Text("/r/MemeEconomy"),
      ),
      body: body,
    );
  }
}