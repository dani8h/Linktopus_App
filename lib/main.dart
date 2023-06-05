import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './job_select.dart';
import './login/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:linktopus_app/SignUp/codeverification.dart';
import 'package:linktopus_app/SignUp/googlesignin.dart';
import 'package:linktopus_app/SignUp/otplogin.dart';
import 'package:linktopus_app/profile.dart';

import 'getstarted1.dart';
import 'joblistings.dart';
// import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: Profile(),
      home: Landing_Page(),
      //home: JobListings(),
    );
  }
}
