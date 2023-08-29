import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomTextbox extends StatefulWidget {
  final String text;
  final bool isPressed;
  final Function(bool) onPressed;

  const CustomTextbox(
      {super.key, required this.text, required this.isPressed, required this.onPressed});

  @override
  _CustomTextboxState createState() => _CustomTextboxState();
}

class _CustomTextboxState extends State<CustomTextbox> {
  late bool _isPressed;

  @override
  void initState() {
    super.initState();
    _isPressed = widget.isPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        splashColor: _isPressed
            ? const Color(0xffE02D72).withOpacity(0.5)
            : const Color.fromRGBO(231, 168, 193, 1),
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(39),
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.22,
          //height: MediaQuery.of(context).size.height * 0.044,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(39),
              topRight: Radius.circular(39),
              bottomLeft: Radius.circular(39),
              bottomRight: Radius.circular(39),
            ),
            color: _isPressed
                ? const Color(0xffE02D72).withOpacity(0.5)
                : const Color.fromRGBO(224, 44, 114, 0.10000000149011612),
            border: Border.all(
              color: const Color.fromRGBO(231, 168, 193, 1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 20, bottom: 20),
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                      fontWeight: FontWeight.w400,
                      color: _isPressed ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _isPressed = !_isPressed;
            widget.onPressed(_isPressed);
          });
        },
      ),
    );
  }
}
