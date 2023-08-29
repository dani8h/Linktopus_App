import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linktopus_app/SplashScreen/getstarted.dart';
import 'firebase_options.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      primaryColor: const Color(0xffEF5DA8),
      primarySwatch: const MaterialColor(0xffEF5DA8, {
        50: Color(0xFFFCE4F6),
        100: Color(0xFFFFD1E2),
        200: Color(0xFFFFACC6),
        300: Color(0xFFFF85AA),
        400: Color(0xFFFF5D8D),
        500: Color(0xffEF5DA8), // primaryColor
        600: Color(0xFFE54691),
        700: Color(0xFFD73C80),
        800: Color(0xFFC5326E),
        900: Color(0xFFA71D54),
      }),
      // Customize other theme properties as needed
      // fontFamily: 'Roboto',
      // textTheme: TextTheme(
      //   headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //   bodyText2: TextStyle(fontSize: 16),
      // ),
    );

    return const MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const GetStarted(),
      ),
    );
  }
}
