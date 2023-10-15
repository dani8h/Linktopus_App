import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/SignUp/googlesignin.dart';
import 'package:linktopus_app/SplashScreen/getstarted.dart';

class SlidingScreen extends StatefulWidget {
  const SlidingScreen({super.key});

  @override
  _SlidingScreenState createState() => _SlidingScreenState();
}

class _SlidingScreenState extends State<SlidingScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => const GetStarted()),
      );
    }
  }

  void _goToNextPage() {
    if (_currentPageIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailSignin()),
      );
    }
  }

  Widget _buildPageIndicator(int pageIndex) {
    return Container(
      width: _currentPageIndex == pageIndex ? 17.0 : 16.0,
      height: _currentPageIndex == pageIndex ? 17.0 : 16.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPageIndex == pageIndex ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPageIndicator(0),
        _buildPageIndicator(1),
        _buildPageIndicator(2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFC11E5D),
              Color(0xFF2F3676),
            ],
            stops: [0.0, 1.0],
            transform: GradientRotation(168.24 * 3.14159 / 180),
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                Column(children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                  SvgPicture.asset(
                    'assets/images/img_screen_1.svg',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Connect directly with your Recruiters!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 15, right: 15, bottom: 0),
                    child: Text(
                      'No annoying middle men!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffCFCFCF),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
                Column(children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                  SvgPicture.asset('assets/images/img_screen_2.svg'),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Hire people you want!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 15, right: 15, bottom: 0),
                    child: Text(
                      'Connect directly with qualified candidates that meet your requirements',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffCFCFCF),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
                Column(children: [
                  SizedBox(
                    height: height * 0.2,
                  ),
                  SvgPicture.asset('assets/images/img_screen_3.svg'),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Learn and Grow!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 15, right: 15, bottom: 0),
                    child: Text(
                      'Need to learn a new skill for a new job you’re applying? we’ve got you covered!',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffCFCFCF),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
              ],
            ),
            Positioned(
              bottom: height * 0.05,
              left: width * 0.07,
              child: GestureDetector(
                onTap: _goToPreviousPage,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          'Back',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height * 0.05,
              right: width * 0.07,
              child: GestureDetector(
                onTap: _goToNextPage,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10, bottom: 10, right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Next',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: height * .125,
              left: 0,
              right: 0,
              child: _buildPageIndicators(),
            ),
            Positioned(
                bottom: height * 0.83,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/Logo_white.png',
                  height: height * 0.1,
                ))
          ],
        ),
      ),
    );
  }
}
