import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign-IN

  signIngWithGoogle() async {
    //signing process starts
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtaining auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //finally signing in the user with credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
