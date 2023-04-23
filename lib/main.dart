import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './job_selection.dart';
import 'package:linktopus_app/SignUp/codeverification.dart';
import 'package:linktopus_app/SignUp/googlesignin.dart';
import 'package:linktopus_app/SignUp/otplogin.dart';
import 'package:linktopus_app/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JobSelection(),
    );
  }
}
