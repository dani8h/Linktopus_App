import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobSelection extends StatefulWidget {
  const JobSelection({Key? key}) : super(key: key);

  @override
  State<JobSelection> createState() => _JobSelectionState();
}

class _JobSelectionState extends State<JobSelection> {
  bool softwarePressed = false;
  bool financePressed = false;
  bool marketingPressed = false;
  bool healthcarePressed = false;
  bool businessPressed = false;
  bool retailPressed = false;
  bool hospitalityPressed = false;
  bool adminPressed = false;
  bool artPressed = false;
  bool socialPressed = false;
  Color _colorContainer = Color.fromRGBO(224, 45, 113, 0.098);
  Color _colorContainer1 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer2 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer3 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer4 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer5 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer6 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer7 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer8 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer9 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);
  Color _colorContainer10 = Color.fromRGBO(224, 44, 114, 0.10000000149011612);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(child: Container()),
                Image.asset('assets/images/Linktopus_app.png'),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 5),
            child: Text(
              'Choose the job roles you are interested in...',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Ink(
                    child: InkWell(
                      splashColor: _colorContainer,
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(39),
                      child: Container(
                        width: width * 0.24,
                        height: height * 0.044,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(39),
                            topRight: Radius.circular(39),
                            bottomLeft: Radius.circular(39),
                            bottomRight: Radius.circular(39),
                          ),
                          color: _colorContainer,
                          border: Border.all(
                            color: Color.fromRGBO(231, 168, 193, 1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Software",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _colorContainer = _colorContainer ==
                                  Color(0xffE02D72).withOpacity(0.5)
                              ? Color.fromRGBO(224, 44, 114, 0.1)
                              : Color(0xffE02D72).withOpacity(0.5);
                          softwarePressed = !softwarePressed;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Ink(
                    child: InkWell(
                      splashColor: _colorContainer1,
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(39),
                      child: Container(
                        width: width * 0.24,
                        height: height * 0.044,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(39),
                            topRight: Radius.circular(39),
                            bottomLeft: Radius.circular(39),
                            bottomRight: Radius.circular(39),
                          ),
                          color: _colorContainer1,
                          border: Border.all(
                            color: Color.fromRGBO(231, 168, 193, 1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Finance",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _colorContainer1 = _colorContainer1 ==
                                  Color(0xffE02D72).withOpacity(0.5)
                              ? Color.fromRGBO(224, 44, 114, 0.1)
                              : Color(0xffE02D72).withOpacity(0.5);
                          financePressed = !financePressed;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Ink(
                    child: InkWell(
                      splashColor: _colorContainer2,
                      splashFactory: InkRipple.splashFactory,
                      borderRadius: BorderRadius.circular(39),
                      child: Container(
                        width: width * 0.24,
                        height: height * 0.044,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(39),
                            topRight: Radius.circular(39),
                            bottomLeft: Radius.circular(39),
                            bottomRight: Radius.circular(39),
                          ),
                          color: _colorContainer2,
                          border: Border.all(
                            color: Color.fromRGBO(231, 168, 193, 1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Marketing",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: width * 0.038,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _colorContainer2 = _colorContainer2 ==
                                  Color(0xffE02D72).withOpacity(0.5)
                              ? Color.fromRGBO(224, 44, 114, 0.1)
                              : Color(0xffE02D72).withOpacity(0.5);
                          marketingPressed = !marketingPressed;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34.0),
            child: Row(
              children: [
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer4,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.54,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer4,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Healthcare & Medicine",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer4 = _colorContainer4 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        healthcarePressed = !healthcarePressed;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer5,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.22,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer5,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Business",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer5 = _colorContainer5 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        businessPressed = !businessPressed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 20),
            child: Row(
              children: [
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer6,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.21,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer6,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Retail",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer6 = _colorContainer6 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        retailPressed = !retailPressed;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer2,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.26,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer7,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Hospitality",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer7 = _colorContainer7 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        hospitalityPressed = !hospitalityPressed;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer8,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.32,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer8,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Administrative",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer8 = _colorContainer8 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        adminPressed = !adminPressed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 33.0, top: 20),
            child: Row(
              children: [
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer9,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.57,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer9,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Art & Entertainment",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer9 = _colorContainer9 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        artPressed = !artPressed;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Ink(
                  child: InkWell(
                    splashColor: _colorContainer10,
                    splashFactory: InkRipple.splashFactory,
                    borderRadius: BorderRadius.circular(39),
                    child: Container(
                      width: width * 0.22,
                      height: height * 0.044,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(39),
                          topRight: Radius.circular(39),
                          bottomLeft: Radius.circular(39),
                          bottomRight: Radius.circular(39),
                        ),
                        color: _colorContainer10,
                        border: Border.all(
                          color: Color.fromRGBO(231, 168, 193, 1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Social",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: width * 0.038,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _colorContainer10 = _colorContainer10 ==
                                Color(0xffE02D72).withOpacity(0.5)
                            ? Color.fromRGBO(224, 44, 114, 0.1)
                            : Color(0xffE02D72).withOpacity(0.5);
                        socialPressed = !socialPressed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.18,
          ),
          GestureDetector(
            onTap: () {
              {}
            },
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Continue",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )),
                    ]),
                width: width * 0.8,
                height: height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(61),
                    topRight: Radius.circular(61),
                    bottomLeft: Radius.circular(61),
                    bottomRight: Radius.circular(61),
                  ),
                  gradient: LinearGradient(
                      begin:
                          Alignment(0.7424360513687134, 0.011676779016852379),
                      end: Alignment(
                          -0.011676778085529804, 0.015544017776846886),
                      colors: [
                        Color.fromRGBO(193, 30, 93, 1),
                        Color.fromRGBO(47, 54, 118, 1)
                      ]),
                )),
          ),
        ]),
      ),
    ));
  }
}

// import 'package:flutter/material.dart';

// class JobselectionWidget extends StatelessWidget {
//           @override
//           Widget build(BuildContext context) {
//           // Figma Flutter Generator JobselectionWidget - FRAME
//             return Container(
//       width: 428,
//       height: 926,
//       decoration: BoxDecoration(
//           color : Color.fromRGBO(255, 255, 255, 1),
//   ),
//       child: Stack(
//         children: <Widget>[
//           Positioned(
//         top: 60,
//         left: 308,
//         child: Container(
//         width: 98,
//         height: 98,
//         decoration: BoxDecoration(
//           image : DecorationImage(
//           image: AssetImage('assets/images/Linktopuslogo.png'),
//           fit: BoxFit.fitWidth
//       ),
//   )
//       )
//       ),Positioned(
//         top: 190,
//         left: 26,
//         child: Text('Choose the job roles you are interested in...', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 30,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 67,
//         left: 36,
//         child: null
//       ),Positioned(
//         top: 325,
//         left: 26,
//         child: Container(
//         width: 110,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 381,
//         left: 262,
//         child: Container(
//         width: 103,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 437,
//         left: 26,
//         child: Container(
//         width: 79,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 437,
//         left: 118,
//         child: Container(
//         width: 119,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 437,
//         left: 250,
//         child: Container(
//         width: 147,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 493,
//         left: 26,
//         child: Container(
//         width: 215,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 493,
//         left: 250,
//         child: Container(
//         width: 75,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 549,
//         left: 26,
//         child: Container(
//         width: 157,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 325,
//         left: 152,
//         child: Container(
//         width: 110,
//         height: 38,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(39),
//             topRight: Radius.circular(39),
//             bottomLeft: Radius.circular(39),
//             bottomRight: Radius.circular(39),
//           ),
//       color : Color.fromRGBO(224, 44, 114, 0.10000000149011612),
//       border : Border.all(
//           color: Color.fromRGBO(231, 168, 193, 1),
//           width: 1,
//         ),
//   )
//       )
//       ),Positioned(
//         top: 331,
//         left: 43,
//         child: Text('Software', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 387,
//         left: 277,
//         child: Text('Business', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 443,
//         left: 41,
//         child: Text('Retail', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 443,
//         left: 133,
//         child: Text('Hospitality', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 443,
//         left: 265,
//         child: Text('Administrative', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 499,
//         left: 41,
//         child: Text('Art and Entertainment', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 499,
//         left: 265,
//         child: Text('Retail', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 555,
//         left: 41,
//         child: Text('Social Services', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 331,
//         left: 174,
//         child: Text('Finance', textAlign: TextAlign.left, style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontFamily: 'Poppins',
//         fontSize: 17,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),Positioned(
//         top: 753,
//         left: 59,
//         child: Container(
//       width: 311,
//       height: 45,

//       child: Stack(
//         children: <Widget>[
//           Positioned(
//         top: 0,
//         left: 0,
//         child: Container(
//         width: 311,
//         height: 45,
//         decoration: BoxDecoration(
//           borderRadius : BorderRadius.only(
//             topLeft: Radius.circular(61),
//             topRight: Radius.circular(61),
//             bottomLeft: Radius.circular(61),
//             bottomRight: Radius.circular(61),
//           ),
//       gradient : LinearGradient(
//           begin: Alignment(0.7424360513687134,0.011676779016852379),
//           end: Alignment(-0.011676778085529804,0.015544017776846886),
//           colors: [Color.fromRGBO(193, 30, 93, 1),Color.fromRGBO(47, 54, 118, 1)]
//         ),
//   )
//       )
//       ),Positioned(
//         top: 10,
//         left: 118,
//         child: Text('Continue', textAlign: TextAlign.center, style: TextStyle(
//         color: Color.fromRGBO(255, 255, 255, 1),
//         fontFamily: 'Poppins',
//         fontSize: 15,
//         letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
//         fontWeight: FontWeight.normal,
//         height: 1
//       ),)
//       ),
//         ]
//       )
//     )
//       ),Positioned(
//         top: 0,
//         left: -1,
//         child: null
//       ),Positioned(
//         top: 325,
//         left: 277,
//         child: null
//       ),Positioned(
//         top: 381,
//         left: 26,
//         child: null
//       ),
//         ]
//       )
//     );
//           }
//         }
