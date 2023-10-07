import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/login/landing_page.dart';

bool _passwordVisible = false;

class EmailSignin extends StatefulWidget {
  const EmailSignin({super.key});

  @override
  State<EmailSignin> createState() => _EmailSigninState();
}

class _EmailSigninState extends State<EmailSignin> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: fem * 20, right: fem * 20, top: fem * 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: const Color(0xff243443),
                      size: 25 * ffem,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Linktopus_app.png',
                        width: 180 * fem,
                        height: 180 * fem,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        // signinwithgoogleYxG (24:510)
                        margin: EdgeInsets.fromLTRB(
                            1 * fem, 0 * fem, 0 * fem, 49 * fem),
                        child: Text(
                          'Sign in with Google',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 18 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2125 * ffem / fem,
                            color: const Color(0xff243443),
                          ),
                        ),
                      ),
                      // Container(
                      //   color: Colors.transparent,
                      //   width: fem * 0,
                      //   height: fem * 0,
                      // ),
                    ],
                  ),
                  Container(
                    color: Colors.transparent,
                    width: fem * 1,
                    height: fem * 1,
                  ),
                ],
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(12 * fem, 0 * fem, 0 * fem, 19.31 * fem),
              // padding: EdgeInsets.fromLTRB(
              //     23.64 * fem, 21.23 * fem, 23.64 * fem, 25.46 * fem),
              width: 377 * fem,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffaab0b7)),
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(8 * fem),
                gradient: const LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: <Color>[Color(0xffffffff), Color(0x00ffffff)],
                  stops: <double>[0, 1],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: fem * 23.64),
                child: TextFormField(
                  style: GoogleFonts.poppins(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: const Color(0xff000000),
                  ),
                  controller: _mailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the email',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * ffem / fem,
                      color: const Color.fromARGB(141, 198, 195, 195),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              // inputenableqwN (24:511)
              margin:
                  EdgeInsets.fromLTRB(12 * fem, 0 * fem, 0 * fem, 19.31 * fem),
              // padding: EdgeInsets.fromLTRB(
              //     23.64 * fem, 21.23 * fem, 23.64 * fem, 25.46 * fem),
              width: 377 * fem,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffaab0b7)),
                color: const Color(0xffffffff),
                borderRadius: BorderRadius.circular(8 * fem),
                gradient: const LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: <Color>[Color(0xffffffff), Color(0x00ffffff)],
                  stops: <double>[0, 1],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: fem * 23.64),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText:
                      !_passwordVisible, //This will obscure text dynamically
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // labelStyle: TextStyle(
                    //   color: Colors.black,
                    // ),
                    // labelText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * ffem / fem,
                      color: const Color.fromARGB(141, 198, 195, 195),
                    ),
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: _passwordVisible ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                          print(_passwordVisible);
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(0 * fem, 0 * fem, 216 * fem, 171 * fem),
              child: Text(
                'Forgot password?',
                style: GoogleFonts.inter(
                  fontSize: 12 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125 * ffem / fem,
                  decoration: TextDecoration.underline,
                  color: const Color(0xff243443),
                  decorationColor: const Color(0xff243443),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(35 * fem, 0 * fem, 35 * fem, 35 * fem),
              width: double.infinity,
              height: 62 * fem,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(51, 0, 0, 0),
                    offset: const Offset(0, 4),
                    blurRadius: 16 * fem,
                  ),
                  BoxShadow(
                    color: const Color.fromARGB(51, 0, 0, 0),
                    offset: const Offset(0, 4),
                    blurRadius: 16 * fem,
                  )
                ],
                borderRadius: BorderRadius.circular(8 * fem),
                gradient: const LinearGradient(
                  begin: Alignment(1, -5.315),
                  end: Alignment(-1, 4.63),
                  colors: <Color>[Color(0xffe02c72), Color(0xff4175df)],
                  stops: <double>[0, 1],
                ),
              ),
              child: Center(
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 24 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.2125 * ffem / fem,
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 9 * fem),
              child: Text(
                'Dont have an account?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w500,
                  height: 1.2125 * ffem / fem,
                  color: const Color(0xff243443),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Landing_Page(),
                  ),
                );
              },
              child: Text(
                'Sign up here',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.2125 * ffem / fem,
                  color: const Color(0xffe02c72),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
