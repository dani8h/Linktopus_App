import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linktopus_app/job_listing/jobsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../profile.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signIngWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user == null) {
        print("NUll");
        return null;
      }

      // Check if user exists in Firebase
      final userExists = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final uid = _auth.currentUser?.uid;
      print(uid);
      if (!userExists.exists) {
        // Redirect to Profile() under profile.dart
        final uid = _auth.currentUser?.uid;
        print(uid);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      } else {
        // Set SharedPreferences to indicate that the user is logged in
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Jobs_page()),
        );
        if (prefs.getBool('isLoggedIn') == true) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Welcome Back ${user.displayName}!"),
                content: Text("You are logged in."),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close"),
                  ),
                ],
              );
            },
          );
        }
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
