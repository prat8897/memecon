import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


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

  final result = await FlutterWebAuth.authenticate(url: authUrl.toString(), callbackUrlScheme: "memeconapp");
  print("THE RESULT IS: " + result.toString());
  
  final accessCode = Uri.parse(result).queryParameters['code'].toString();
  print("THE ACCESS CODE IS: " + accessCode);
  await reddit.auth.authorize(accessCode);
  print(await reddit.user.me());
  print(reddit.auth.credentials.toJson().toString());

  final storage = new FlutterSecureStorage();
  await storage.write(key: "credentialsJSON", value: reddit.auth.credentials.toJson().toString());

  //String credentials = await storage.read(key: "credentialsJSON");
  //print(credentials);
}

Future<Null> restoreRedditUser(credentialsJSON) async {
  final reddit = await Reddit.restoreAuthenticatedInstance(
    credentialsJSON,
    clientId: clientId,
    clientSecret: clientSecret,
    userAgent: userAgent,
    redirectUri: redirectUri,
  );
}