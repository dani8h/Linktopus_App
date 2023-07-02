import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linktopus_app/job_listing/jobsPage.dart';
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
          MaterialPageRoute(builder: (context) => Profile()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Jobs_page()),
        );
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
