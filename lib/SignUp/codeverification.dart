import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linktopus_app/SignUp/otplogin.dart';
import 'package:linktopus_app/job_listing/jobsPage.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: fem * 30, right: fem * 30),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Linktopus_app.png',
                width: fem * 250,
                height: fem * 250,
              ),
              SizedBox(
                height: fem * 20,
              ),
              Text(
                "Phone Verification",
                style: GoogleFonts.inter(
                    fontSize: fem * 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: fem * 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: GoogleFonts.poppins(
                  fontSize: fem * 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: fem * 50,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,

                onChanged: (value) {
                  code = value;
                  print(code);
                },
                //onCompleted: (pin) => code = pin,
              ),
              SizedBox(
                height: fem * 25,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    print("Code: $code");
                    print("Verification ID: ${OtpPage.verify}");
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: OtpPage.verify, smsCode: code);

                    await auth.signInWithCredential(credential);
                    final uid = auth.currentUser?.uid;
                    print(uid);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Jobs_page()),
                    );
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Wrong OTP"),
                          actions: [
                            ElevatedButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                    height: fem * 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          offset: Offset(0, 4),
                          blurRadius: 16 * fem,
                        ),
                        BoxShadow(
                          color: Color.fromARGB(51, 0, 0, 0),
                          offset: Offset(0, 4),
                          blurRadius: 16 * fem,
                        )
                      ],
                      borderRadius: BorderRadius.circular(8 * fem),
                      gradient: LinearGradient(
                        begin: Alignment(1, -5.315),
                        end: Alignment(-1, 4.63),
                        colors: <Color>[Color(0xffe02c72), Color(0xff4175df)],
                        stops: <double>[0, 1],
                      ),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Verify Phone Number",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 24 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.2125 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    )),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
