import 'dart:async';
import 'package:flutter/material.dart';
import 'package:draw/draw.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostView extends StatefulWidget {
  const PostView({
    Key key,
    @required this.post,
    this.comments,
  }) : super(key: key);

  final Submission post;
  final CommentForest comments;

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    // populatePost();
    _listController.addListener(_scrollListener);
  }

  PageController _postViewController = PageController();
  TrackingScrollController _listController = TrackingScrollController();
  CommentForest _postComments;

  void _scrollListener() {
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

    Widget memepost() {
      Widget body() {
        if (widget.post.isSelf) {
          return Center(child: Text(widget.post.selftext));
        } else {
          return Center(
            // child: Image.network(widget.post.url.toString())
            child: CachedNetworkImage(
              imageUrl: widget.post.url.toString(),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          );
        }
      }

      return Stack(
        children: <Widget>[
          body(),
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
    }

  @override
  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.vertical,
      controller: _postViewController,
      children: <Widget>[
        memepost(),
        comments(),
      ],
    );
  }
}
