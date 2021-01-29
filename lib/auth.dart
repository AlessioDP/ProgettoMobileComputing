import 'package:firebase_auth/firebase_auth.dart';

void authSignOut() {
  FirebaseAuth.instance.signOut();
}