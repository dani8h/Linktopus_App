import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/SplashScreen/sliding_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffC11E5D), Color(0xff2F3676)],
              stops: [0.0, 1.0],
              transform: GradientRotation(168.24 * 3.14159 / 180),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.04,
                right: size.width * 0.04,
                bottom: size.height * 0.02,
                top: size.height * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/images/Linktopus white.svg',
                  height: size.height * 0.1,
                  width: size.width * 0.35,
                ),
                SizedBox(
                  height: size.height * 0.025,
                ),
                SvgPicture.asset(
                  'assets/images/Onboarding_1.svg',
                  height: size.height * 0.4,
                  width: size.width * 0.5,
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Jobs at your fingertips!',
                              style: GoogleFonts.poppins(
                                fontSize: size.height * 0.036,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Match with recruiters or employees easily with Linktopus Jobs!',
                            style: GoogleFonts.poppins(
                              fontSize: size.height * 0.022,
                              color: const Color(0xffCFCFCF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SlidingScreen(),
                              ),
                            ),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: size.width * 0.8,
                                height: size.height * 0.066,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Let\'s get started',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: size.height * 0.028,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.black,
                                      size: size.height * 0.04,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
