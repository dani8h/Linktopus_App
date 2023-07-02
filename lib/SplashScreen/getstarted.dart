import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/SplashScreen/sliding_screen.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
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
                Image.asset(
                  'assets/images/Logo_white.png',
                  height: size.height * 0.1,
                  width: size.width * 0.35,
                ),
                Image.asset(
                  'assets/images/Onboarding 1 figure.png',
                  height: size.height * 0.4,
                  width: size.width * 0.5,
                ),
                Expanded(
                  child: Container(
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Jobs at your fingertips!',
                            style: GoogleFonts.poppins(
                              fontSize: size.height * 0.036,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Match with recruiters or employees',
                            style: GoogleFonts.poppins(
                              fontSize: size.height * 0.022,
                              color: Color(0xffCFCFCF),
                            ),
                          ),
                          Text(
                            'easily with Linktopus Jobr!',
                            style: GoogleFonts.poppins(
                              fontSize: size.height * 0.022,
                              color: Color(0xffCFCFCF),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SlidingScreen(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Lets get started',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: size.height * 0.028,
                                        fontWeight: FontWeight.w400,
                                      ),
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
