import 'dart:async';
import 'package:draw/draw.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String clientId = "-hEXzInaY1Mrrw";
String clientSecret = "";
String userAgent = "test_flutter";
Uri redirectUri = Uri.parse("memeconapp://login");

Future<Reddit> initializeRedditUser() async {
  final reddit = Reddit.createWebFlowInstance(
    clientId: clientId,
    clientSecret: clientSecret,
    userAgent: userAgent,
    redirectUri: redirectUri,
  );

  //Generate the authentication URI
  final authUrl = reddit.auth.url(['*'], userAgent, compactLogin: true);

  //Go to reddit.com via chrome, login, and authenticate app with client
  final result = await FlutterWebAuth.authenticate(url: authUrl.toString(), callbackUrlScheme: "memeconapp");

  //Parse access code from callback Uri
  final accessCode = Uri.parse(result).queryParameters['code'].toString();

  //authorise app with reddit
  await reddit.auth.authorize(accessCode);

  print("AUTH URL:" + authUrl.toString());
  print("THE CALLBACK RESULT IS: " + result.toString());
  print("THE ACCESS CODE IS: " + accessCode);
  print(await reddit.user.me());
  print(reddit.auth.credentials.toJson().toString());

  //Flutter Secure Storage to save reddit credentials
  //https://github.com/mogol/flutter_secure_storage
  
  final storage = new FlutterSecureStorage();
  await storage.write(key: "credentialsJSON", value: reddit.auth.credentials.toJson().toString());

  return reddit;
}

Future<Reddit> restoreRedditUser(credentialsJSON) async {
  final reddit = await Reddit.restoreAuthenticatedInstance(
    credentialsJSON,
    clientId: clientId,
    clientSecret: clientSecret,
    userAgent: userAgent,
    redirectUri: redirectUri,
  );
  print(await reddit.user.me());
  return reddit;
}