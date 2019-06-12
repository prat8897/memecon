import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:memecon/settings_page.dart';
import 'package:memecon/Services/auth_flow.dart';
import 'Components/left_drawer.dart';

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
  //leftdrawer state
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController _controller = PageController(
    keepPage: false,
  );

  List<Submission> submissions = [];
  int _stackindex = 0;

  @override
  void initState() {
    super.initState();

    fetchPosts();
  }

  //TODO make this a <Future>, put fetchposts in services
  void fetchPosts() {
    Stream hotPosts = widget.reddit.subreddit('MemeEconomy').hot();
    hotPosts.map((content) => content as Submission);
    hotPosts.listen((onData) {
      setState(() {
        submissions.add(onData);
      });
    });
    print(submissions.length);
  }

  SliverGrid gridBody() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          /*
          PostView newPostView = PostView(
              key: ValueKey<String>(submissions.elementAt(index).id),
              post: Post(submission: submissions.elementAt(index))
          );
          */
          return InkWell(
            onTap: () {
              setState(() {
                _stackindex = 1;
                _controller.jumpToPage(index);
              });
            },
            child: Image.network(
              submissions.elementAt(index).thumbnail.toString()
            ),
          );
        },
        childCount: submissions.length,
      ),
    );
  }

  PageView pageView() {
    return PageView(
      //itemCount: submissions.length,
      controller: _controller,
      children: <Widget>[
        for (Submission post in submissions)
          Image.network(post.url.toString())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: LeftDrawer(),
      body: IndexedStack(
        index: _stackindex,
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: false,
                pinned: false,
                snap: false,
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()),
                centerTitle: true,
                title: Text("/r/MemeEconomy"),
              ),
              gridBody(),
              //gridd(),
            ],
          ),
          Scaffold(
              body: WillPopScope(
            onWillPop: () {
              setState(() => _stackindex = 0);
            },
            child: pageView(),
          )),
        ],
      ),
    );
  }
}
