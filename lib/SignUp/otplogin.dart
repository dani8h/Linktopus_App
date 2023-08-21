import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/SignUp/codeverification.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController countryController = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
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
              Container(
                height: fem * 60,
                decoration: BoxDecoration(
                    border: Border.all(width: fem * 1.25, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: fem * 15,
                    ),
                    SizedBox(
                      width: fem * 45,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: GoogleFonts.poppins(fontSize: fem * 38, color: Colors.grey),
                    ),
                    SizedBox(
                      width: fem * 15,
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: fem * 25,
              ),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countryController.text + phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      OtpPage.verify = verificationId;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Verify()));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: Container(
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
                  height: fem * 60,
                  child: Center(
                    child: Text(
                      "Send the code",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
