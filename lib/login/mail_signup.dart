import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linktopus_app/SignUp/googlesignin.dart';

bool _passwordVisible = false;
bool _confirmPasswordVisible = false;

class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter an email address';
    }

    String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp emailRegExp = RegExp(emailRegex);
    if (!emailRegExp.hasMatch(email)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String? password) {
    // Password validation: at least 8 characters with a mix of numbers and letters
    String passwordRegex = r'^.{8,}$';
    RegExp passwordRegExp = RegExp(passwordRegex);
    if (!passwordRegExp.hasMatch(password!)) {
      return 'Password must be at least 8 characters long ';
    }
    return null;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
          email: _mailController.text,
          password: _passwordController.text,
        );

        print('User created successfully');
      } catch (e) {
        print('Error creating user: $e');
        buildSnackBar('Error creating user. Please try again.');
      }
    }
  }

  void _handleSignUpTap() {
    signUpWithEmailAndPassword();
  }

  void buildSnackBar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      key: _scaffoldMessengerKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: fem * 20, right: fem * 20, top: fem * 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: const Color(0xff243443),
                        size: 25 * ffem,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/Linktopus colored.svg',
                          width: 120 * fem,
                          height: 120 * fem,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              1 * fem, 0 * fem, 0 * fem, 49 * fem),
                          child: Text(
                            'Sign up with Email',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2125 * ffem / fem,
                              color: const Color(0xff243443),
                            ),
                          ),
                        ),
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
                margin: EdgeInsets.fromLTRB(
                    12 * fem, 0 * fem, 0 * fem, 19.31 * fem),
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
                      hintText: 'Enter email',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem / fem,
                        color: const Color.fromARGB(141, 198, 195, 195),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    12 * fem, 0 * fem, 0 * fem, 19.31 * fem),
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
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem / fem,
                        color: const Color.fromARGB(141, 198, 195, 195),
                      ),
                      hintText: 'Enter password',
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
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    12 * fem, 0 * fem, 0 * fem, 19.31 * fem),
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
                    controller: _confirmPasswordController,
                    obscureText:
                        !_confirmPasswordVisible, //This will obscure text dynamically
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.5 * ffem / fem,
                        color: const Color.fromARGB(141, 198, 195, 195),
                      ),
                      hintText: 'Confirm password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _confirmPasswordVisible
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: _validateConfirmPassword,
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 216 * fem, 141 * fem),
              ),
              GestureDetector(
                onTap: _handleSignUpTap,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      35 * fem, 0 * fem, 35 * fem, 35 * fem),
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
                      'Sign up',
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
              ),
              Container(
                margin: EdgeInsets.fromLTRB(2 * fem, 0 * fem, 0 * fem, 9 * fem),
                child: Text(
                  'Already have an account?',
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
                      builder: (context) => const EmailSignin(),
                    ),
                  );
                },
                child: Text(
                  'Sign in',
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
      ),
    );
  }
}
