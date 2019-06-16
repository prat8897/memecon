import 'package:flutter/material.dart';
import 'package:memecon/home_page.dart';
import 'Services/auth_flow.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _status = 'no-action';

  @override
  Widget build(BuildContext context) {
    void submit() async {
      setState(() => this._status = 'loading');
      try {
        await initializeRedditUser().then((reddit) {
          setState(() => this._status = 'successful login attempt!');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(reddit: reddit,)),
          );
          print("the sign in button just got clicked");
        });
      } catch (e) {
        setState(() => this._status = 'failed login attempt');
      }
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: submit,
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Log In With Reddit', style: TextStyle(color: Colors.white)),
      ),
    );

    final loginCard = Container(
      color: Colors.lime[100],
      child: Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        child: loginButton,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              loginCard,
            ],
          ),
        ),
      ),
    );
  }
}
