import 'package:SearchIt/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SearchIt/data/database.dart';
import 'package:SearchIt/app_localizations.dart';
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
            child: Text(AppLocalizations.of(context).translate('app_name'),
                style: TextStyle(
                  fontSize: 35,
                ))));

    final widgetLoginGoogle = Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ButtonTheme(
            height: 56,
            child: RaisedButton(
                child: Text(AppLocalizations.of(context).translate('sign_in'),
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  _loginGoogle();
                })));

    final widgetLoginAnon = ButtonTheme(
        height: 56,
        child: FlatButton(
            child: Text(
                AppLocalizations.of(context).translate('sign_in_as_guest'),
                style: TextStyle(color: Colors.black, fontSize: 16)),
            onPressed: () {
              _loginAnonymous();
            }));

    return SafeArea(
        child: Scaffold(
            body: Center(
                child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [widgetLogo, widgetTitle, widgetLoginGoogle, widgetLoginAnon],
    ))));
  }

  void _loginAnonymous() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    firebaseUser = userCredential.user;
    runApp(Homepage(
      title: 'Homepage',
    ));
  }

  void _loginGoogle() async {
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
    runApp(Homepage(
      title: 'Homepage',
    ));
  }
}
