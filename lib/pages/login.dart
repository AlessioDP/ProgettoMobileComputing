import 'package:SearchIt/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widgetLogo = Image(
      image: AssetImage('assets/icons/icon.png'),
      height: 300,
    );

    final widgetTitle = Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text('SearchIt',
                style: TextStyle(
                  fontSize: 35,
                ))));

    final widgetLoginGoogle = Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ButtonTheme(
            height: 56,
            child: RaisedButton(
                child: Text('Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  _loginGoogle(context);
                })));

    final widgetLoginAnon = ButtonTheme(
        height: 56,
        child: FlatButton(
            child: Text('Sign in as Guest',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onPressed: () {
              _loginAnonymous(context);
            }));

    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      //padding: EdgeInsets.symmetric(horizontal: 20),
      children: [widgetLogo, widgetTitle, widgetLoginGoogle, widgetLoginAnon],
    )

                /*istView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [widgetLogo, widgetTitle, widgetLoginGoogle, widgetLoginAnon],
    )*/
                )));
  }

  void _loginAnonymous(BuildContext context) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    firebaseUser = userCredential.user;

    // Load homepage
    _loadHomepage(context);
  }

  void _loginGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    firebaseUser = userCredential.user;

    // Load homepage
    _loadHomepage(context);
  }

  void _loadHomepage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/homepage');
  }
}
