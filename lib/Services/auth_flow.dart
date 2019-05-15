import 'dart:async';
import 'package:draw/draw.dart';
//import 'package:flutter_web_auth/flutter_web_auth.dart';


String clientId = "-hEXzInaY1Mrrw";
String clientSecret = "";
String userAgent = "test_flutter";
Uri redirectUri = Uri.parse("memeconapp://login");

Future<Null> initializeRedditUser() async {
  final reddit = Reddit.createWebFlowInstance(
    clientId: clientId,
    clientSecret: clientSecret,
    userAgent: userAgent,
    redirectUri: redirectUri,
  );

  final authUrl = reddit.auth.url(['*'], userAgent, compactLogin: true);
  print("AUTH URL:" + authUrl.toString());

  /*
  final result = await FlutterWebAuth.authenticate(url: authUrl.toString(), callbackUrlScheme: "memecon8897://flutter_app");
  print("THE RESULT IS: " + result.toString());
  final accessCode = Uri.parse(result).queryParameters['code'].toString();
  print("THE ACCESS CODE IS: " + accessCode);
  await reddit.auth.authorize(accessCode);
  print(await reddit.user.me());
  */
}
