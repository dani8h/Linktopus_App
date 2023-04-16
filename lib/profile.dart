import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:myapp/utils.dart';

String dropdownValue = 'Male';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  final TextEditingController controller_ph = TextEditingController();
  final TextEditingController _date = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      // Do something with the selected file
    } else {
      // User canceled the file selection
    }
  }

  TextEditingController _dateController = TextEditingController();
  TextEditingController _locController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    String initialCountry = 'IN';
    PhoneNumber number = PhoneNumber(isoCode: 'IN');

    return SingleChildScrollView(
      child: Material(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: fem * 110, //mediaquery
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff2F3676), Color(0xffC11E5D)])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          25 * fem, 5 * fem, 0 * fem, 0 * fem),
                      child: Icon(Icons.arrow_back_ios,
                          color: Color(0xffffffff),
                          size: 30 * fem), //mediaquery
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          100 * fem, 5 * fem, 0 * fem, 0 * fem),
                      child: Text(
                        'Edit Profile',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 25 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.5 * ffem / fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin:
                    EdgeInsets.fromLTRB(44 * fem, 0 * fem, 36 * fem, 0 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 3 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                74 * fem, 0 * fem, 74 * fem, 12.52 * fem),
                            padding: EdgeInsets.fromLTRB(
                                138 * fem, 158.86 * fem, 24 * fem, 10.81 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Color(
                                    0xff010088), //                   <--- border color
                                width: 2.0,
                              ),
                              image: image != null
                                  ? DecorationImage(
                                      image: FileImage(image!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                width: 38 * fem,
                                height: 36.81 * fem,
                                child: GestureDetector(
                                  onTap: () => pickImage(),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(
                                              0xff010088), //                   <--- border color
                                          width: 3.0,
                                        ),
                                      ),
                                      child: Icon(Icons.edit_outlined,
                                          color: Color(0xff010088),
                                          size: 20 * fem)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    txtfields('Username', context),
                    txtfields('Bio', context),
                    txtfields('Full Name', context),

                    //ph no
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 7 * fem),
                          child: Text(
                            'Phone Number',
                            style: GoogleFonts.poppins(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // group22wma (40:7649)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 15 * fem),
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffa8a8a8)),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: fem * 10),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: controller_ph,
                              formatInput: false,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputBorder: OutlineInputBorder(),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    txtfields('Qualification', context),

                    selectfield('Date Of Birth', context),
                    // txtfields('Gender', context),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 7 * fem),
                          child: Text(
                            'Gender',
                            style: GoogleFonts.poppins(
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.5 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // group22wma (40:7649)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 15 * fem),
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffa8a8a8)),
                            borderRadius: BorderRadius.circular(8 * fem),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: fem * 15, right: fem * 15),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                focusColor: Colors.black,
                                // icon: const Icon(Icons.arrow_downward),
                                // iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                // underline: Container(
                                //   height: 2,
                                //   color: Colors.deepPurpleAccent,
                                // ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    //print('New value selected: $newValue');
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>['Male', 'Female', 'Others']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    selectfield('Your Location', context),
                    SizedBox(
                      height: fem * 80,
                    ),
                    Container(
                      // group15amE (40:7642)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 31 * fem),
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 12 * fem, 114 * fem, 10 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffa8a8a8)),
                        color: Color(0xff2b3688),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: GestureDetector(
                        onTap: () => selectFile(),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vector5T6 (40:7636)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 76 * fem, 1.91 * fem),
                              width: 20 * fem,
                              height: 19.09 * fem,
                              child: Icon(Icons.upload_rounded,
                                  color: Color(0xffffffff), size: 25 * fem),
                            ),
                            Text(
                              // uploadresumeCXi (40:7638)
                              'Upload Resume',
                              style: GoogleFonts.poppins(
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.5 * ffem / fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // group167ua (40:7643)
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 12 * fem, 91 * fem, 10 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffa8a8a8)),
                        color: Color(0xff0a66c2),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vectorDxc (40:7640)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 52 * fem, 1 * fem),
                            width: 20 * fem,
                            height: 20 * fem,
                            child: Icon(Icons.person,
                                color: Color(0xffffffff), size: 25 * fem),
                          ),
                          Text(
                            // attachlinkedinprofile9bN (40:7641)
                            'Attach LinkedIn Profile',
                            style: GoogleFonts.poppins(
                              fontSize: 15 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * ffem / fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupnngxgbJ (2MnL668EZexYpjmLfcnnGx)
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 27 * fem, 19 * fem, 0 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            // group23QnC (40:7651)
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 45 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5 * fem),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.338, -1),
                                  end: Alignment(1.325, 1),
                                  colors: <Color>[
                                    Color(0xffc11e5d),
                                    Color(0xff2f3676)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // group27RSQ (46:7626)
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5 * fem),
                            ),
                            child: Center(
                              // rectangle31nXr (46:7627)
                              child: SizedBox(
                                width: double.infinity,
                                height: 45 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(5 * fem),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget txtfields(String type, BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 7 * fem),
          child: Text(
            type,
            style: GoogleFonts.poppins(
              fontSize: 14 * ffem,
              fontWeight: FontWeight.w300,
              height: 1.5 * ffem / fem,
              color: Color(0xff000000),
            ),
          ),
        ),
        Container(
          // group22wma (40:7649)
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
          padding: type == 'Bio'
              ? EdgeInsets.fromLTRB(16 * fem, 13 * fem, 16 * fem, 9 * fem)
              : EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffa8a8a8)),
            borderRadius: BorderRadius.circular(8 * fem),
          ),
          child: TextFormField(
            keyboardType:
                type == 'Bio' ? TextInputType.multiline : TextInputType.text,
            maxLines: null,
            style: GoogleFonts.poppins(
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w500,
              height: 1.5 * ffem / fem,
              color: Color(0xff000000),
            ),
            //controller to be filled in
            decoration: InputDecoration(
              contentPadding: type == 'Bio'
                  ? EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 30 * fem)
                  : EdgeInsets.fromLTRB(16 * fem, 13 * fem, 16 * fem, 9 * fem),
              border: InputBorder.none,
              hintText: type,
              hintStyle: GoogleFonts.poppins(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.w500,
                height: 1.5 * ffem / fem,
                color: Color.fromARGB(141, 198, 195, 195),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectfield(String type, BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 7 * fem),
          child: Text(
            type,
            style: GoogleFonts.poppins(
              fontSize: 14 * ffem,
              fontWeight: FontWeight.w300,
              height: 1.5 * ffem / fem,
              color: Color(0xff000000),
            ),
          ),
        ),
        Container(
          // group22wma (40:7649)
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 15 * fem),
          padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xffa8a8a8)),
            borderRadius: BorderRadius.circular(8 * fem),
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextFormField(
                  onTap: () {
                    type == 'Date Of Birth' ? _selectDate() : null;
                  },
                  controller: type == 'Date Of Birth'
                      ? _dateController
                      : _locController, // Assign the TextEditingController to the TextFormField
                  style: GoogleFonts.poppins(
                    fontSize: 15 * ffem,
                    fontWeight: FontWeight.w500,
                    height: 1.5 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                        16 * fem, 13 * fem, 16 * fem, 9 * fem),
                    border: InputBorder.none,
                    hintText:
                        type == 'Date Of Birth' ? type : 'eg: Bengaluru, India',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * ffem / fem,
                      color: Color.fromARGB(141, 198, 195, 195),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0xffA9A9A9),
                height: fem * 51.5,
                width: fem * 1.2,
              ),
              Padding(
                padding: EdgeInsets.only(right: fem * 13, left: fem * 13),
                child: type == 'Date Of Birth'
                    ? Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: fem * 22,
                      )
                    : Icon(
                        Icons.map_outlined,
                        color: Colors.black,
                        size: fem * 23,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

      setState(() {
        _dateController.text =
            formattedDate; // Update the TextFormField's text value with the selected date
      });
    } else {
      print("Date is not selected");
    }
  }

  // void _selectDate() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(
  //         2000), //DateTime.now() - not to allow to choose before today.
  //     lastDate: DateTime(2101),
  //   );

  //   if (pickedDate != null) {
  //     print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
  //     String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
  //     print(
  //         formattedDate); //formatted date output using intl package =>  2021-03-16
  //     //you can implement different kind of Date Format here according to your requirement

  //     setState(() {
  //       _date.text = formattedDate; //set output date to TextField value.
  //     });
  //   } else {
  //     print("Date is not selected");
  //   }
  // }
}
