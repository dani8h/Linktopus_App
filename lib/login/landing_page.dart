import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/services/auth_service.dart';
import '../SignUp/otplogin.dart';
import 'mail_signup.dart';

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
        backgroundColor: const Color(0xffffffff),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.172,
              color: const Color(0xffffffff),
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
                    onTap: () => AuthService().signIngWithGoogle(context),
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
                            SvgPicture.asset("assets/images/google_icon.svg"),
                            SizedBox(
                              width: width * 0.17,
                            ),
                            Text(
                              "Sign in with Google",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.043,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
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
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const EmailSignup())),
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
                            const Icon(Icons.email),
                            SizedBox(
                              width: width * 0.17,
                            ),
                            Text(
                              "Sign up with email",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.043,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
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
                            SvgPicture.asset("assets/images/apple_icon.svg"),
                            SizedBox(
                              width: width * 0.19,
                            ),
                            Text(
                              "Sign in with Apple",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.043,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    "------  OR ------",
                    style: GoogleFonts.poppins(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff58616A)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const OtpPage()));
                    },
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.03)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset("assets/images/facebook_icon.png"),

                            Text(
                              "Continue with phone number",
                              style: GoogleFonts.poppins(
                                fontSize: width * 0.043,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  //Discarded Meta login code

//   facebookLogin() async {
//     try {
//       // Log in with Facebook
//       final LoginResult result = await FacebookAuth.instance.login();

//       // Get the Facebook access token
//       final OAuthCredential credential =
//           FacebookAuthProvider.credential(result.accessToken!.token);

//       // Sign in with the Facebook credential
//       UserCredential firebaseResult =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       final FirebaseAuth auth = FirebaseAuth.instance;
//       // Check if the user exists in Firebase
//       bool exists = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseResult.user!.uid)
//           .get()
//           .then((doc) => doc.exists);

//       final uid = auth.currentUser?.uid;
//       print(uid);

//       if (!exists) {
//         // Redirect to Edit_Profile()

//         Navigator.push(
//             context,
//             // MaterialPageRoute(builder: (context) => Profile()),
//             MaterialPageRoute(builder: (context) => Jobs_page()));
//       } else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => Jobs_page()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       // Handle FirebaseAuthException
//       print('FirebaseAuthException: $e');
//     } catch (e) {
//       // Handle other exceptions
//       print('Error: $e');
//     }
//   }
// }
}
