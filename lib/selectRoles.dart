import 'package:flutter/material.dart';
import 'Widgets/Customtextbox_widget.dart';
//import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectRoles extends StatefulWidget {
  const SelectRoles({super.key});

  @override
  _SelectRolesState createState() => _SelectRolesState();
}

class _SelectRolesState extends State<SelectRoles> {
  List<bool> isPressed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> jobRoles = [
    'Software',
    'Finance',
    'Marketing',
    'Healthcare & Medicine',
    'Business',
    'Retail',
    'Hospitality',
    'Administrative',
    'Art & Entertainment',
    'Social Services'
  ];

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
              padding: const EdgeInsets.all(20),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                children: List.generate(
                  jobRoles.length,
                  (index) => CustomTextbox(
                    text: jobRoles[index],
                    isPressed: isPressed[index],
                    onPressed: (isPressed) {
                      setState(() {
                        this.isPressed[index] = isPressed;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: width * 0.8,
                height: height * 0.06,
                decoration: const BoxDecoration(
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
                ),
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
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
