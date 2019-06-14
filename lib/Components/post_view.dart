import 'dart:async';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';

class PostView extends StatefulWidget {
  const PostView({
    Key key,
    @required this.post,
  }) : super(key: key);

  final Submission post;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    populatePost();
    _listController.addListener(_scrollListener);
  }

  PageController _postViewController = PageController();
  TrackingScrollController _listController = TrackingScrollController();
  CommentForest _postComments;

  _scrollListener() {
    if (_listController.offset <= _listController.position.minScrollExtent &&
        !_listController.position.outOfRange) {
      _postViewController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.linearToEaseOut,
      );
      print("JUMPING TO TOP");
    }
  }

  void populatePost() async {
    await widget.post.populate();
    await widget.post
        .refreshComments(sort: CommentSortType.best)
        .then((comments) {
      if (this.mounted) {
        setState(() {
          _postComments = comments;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final memepost = Stack(
      children: <Widget>[
        Center(child: Image.network(widget.post.url.toString())),
        Text(widget.post.title),
        Align(
          alignment: Alignment.bottomRight,
          child: Text(widget.post.upvotes.toString()),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(widget.post.author),
        ),
      ],
    );

    Widget comments() {
      List<Text> comments = List<Text>();
      if (_postComments != null) {
        for (var comm in _postComments.toList()) {
          if (comm is Comment) {
            comments.add(Text(comm.body));
          }
        }
      } else {
        print("_postComments is null");
        populatePost();
      }

      if (comments != null) {
        return ListView(
          controller: _listController,
          children: <Widget>[...comments],
        );
      }
    }

    return PageView(
      scrollDirection: Axis.vertical,
      controller: _postViewController,
      children: <Widget>[
        memepost,
        comments(),
      ],
    );
  }
}
