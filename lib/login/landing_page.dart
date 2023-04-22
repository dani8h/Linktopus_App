import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linktopus_app/services/auth_service.dart';
import '../firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Landing_Page extends StatefulWidget {
  const Landing_Page({super.key});

  @override
  State<Landing_Page> createState() => _Landing_PageState();
}

class _Landing_PageState extends State<Landing_Page> {
  String userEmail = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.172,
              color: Color(0xffffffff),
            ),
            Positioned(
              top: -65,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/LinktopusLogo.png",

                //height: 20,
              ),
            ),
            SizedBox(
              height: height * 0.2,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.33,
                  ),
                  GestureDetector(
                    onTap: () => AuthService().signIngWithGoogle(),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.03)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 20, bottom: 20),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/google_icon.png"),
                            SizedBox(
                              width: width * 0.17,
                            ),
                            Text(
                              "Sign in with Google",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () => facebookLogin(),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.03)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 20, bottom: 20),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/facebook_icon.png"),
                            SizedBox(
                              width: width * 0.17,
                            ),
                            Text(
                              "Sign in with Facebook",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.03)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 20, bottom: 20),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/apple_icon.png"),
                            SizedBox(
                              width: width * 0.19,
                            ),
                            Text(
                              "Sign in with Apple",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Text(
                    "------  OR ------",
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff58616A)),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff243443)),
                  ),
                  SizedBox(
                    height: height * 0.007,
                  ),
                  GestureDetector(
                    child: Container(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffC11E5D)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  facebookLogin() async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print('facebook_login_data:-');
        print(userData);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(image: userData['picture']['data']['url'],
        //   name: userData['name'], email: userData['email'])));
      }
    } catch (error) {
      print(error);
    }
  }
}
