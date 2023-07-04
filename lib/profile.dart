import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:myapp/utils.dart';

String _dropdownValue = 'Male';

class Profile extends StatefulWidget {
  final uid;

  Profile({Key? key, @required this.uid}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;
  //final TextEditingController controller_ph = TextEditingController();
  String controller_ph = "";
  //final TextEditingController _date = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _qualification = TextEditingController();
  bool isPaidUser = false;

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
      String fileName = result.files.single.name;

      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Upload file?"),
            content: Text("Do you want to upload $fileName?"),
            actions: <Widget>[
              TextButton(
                child: Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (confirm) {
        // Upload file to Firebase Storage
        //String user = _username.text;
        final id = widget.uid;
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('users/$id/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(file);

        // Get download URL for the file
        String downloadURL = await uploadTask.then(
          (snapshot) => snapshot.ref.getDownloadURL(),
        );

        // Update user's document in Firestore with the download URL
        String username = _username.text; // replace with the user's username
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentReference userDocRef =
            firestore.collection('users').doc(widget.uid);
        await userDocRef.update({
          'Resume': downloadURL,
        });

        print(
            'File uploaded to Firebase Storage and download URL updated in Firestore');

        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('User Resume Updated'),
            content:
                Text('User $username resume has been updated successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    } else {
      // User canceled the file selection

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('No file selected'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  // Future<void> selectFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     String fileName = result.files.single.name;

  //     bool confirm = await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Upload file?"),
  //           content: Text(
  //               "Do you want to upload $fileName?; (Username field must not be empty)"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("No"),
  //               onPressed: () => Navigator.of(context).pop(false),
  //             ),
  //             TextButton(
  //               child: Text("Yes"),
  //               onPressed: () => Navigator.of(context).pop(true),
  //             ),
  //           ],
  //         );
  //       },
  //     );

  //     if (confirm) {
  //       FirebaseFirestore firestore = FirebaseFirestore.instance;
  //       String username = _username.text;
  //       final userCollectionRef = firestore.collection('users');

  //       QuerySnapshot querySnapshot = await userCollectionRef
  //           .where('Username', isEqualTo: username)
  //           .limit(1)
  //           .get();
  //       bool exists = querySnapshot.docs.isNotEmpty;
  //       String userid = querySnapshot.docs[0].id;
  //       // Upload file to Firebase Storage

  //       DocumentReference userDocRef =
  //           firestore.collection('users').doc(userid);

  //       if (exists) {
  //         String user = _username.text;
  //         Reference firebaseStorageRef =
  //             FirebaseStorage.instance.ref().child('users/$userid/$fileName');
  //         UploadTask uploadTask = firebaseStorageRef.putFile(file);

  //         // Get download URL for the file
  //         String downloadURL = await uploadTask.then(
  //           (snapshot) => snapshot.ref.getDownloadURL(),
  //         );

  //         //Update user's document in Firestore with the download URL
  //         await userDocRef.update({
  //           'Resume': downloadURL,
  //         });

  //         print(
  //             'File uploaded to Firebase Storage and download URL updated in Firestore');

  //         // Show success dialog
  //         showDialog(
  //           context: context,
  //           builder: (context) => AlertDialog(
  //             title: const Text('User Resume Updated'),
  //             content:
  //                 Text('User $username resume has been updated successfully'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               )
  //             ],
  //           ),
  //         );
  //       } else
  //         return;
  //     }
  //   } else {
  //     // User canceled the file selection

  //     // Show success dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text('Error'),
  //         content: Text('No file selected'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           )
  //         ],
  //       ),
  //     );
  //   }
  // }

  // Future<void> sendUserData(
  //   String username,
  //   String bio,
  //   String fullName,
  //   String phoneNumber,
  //   String qualification,
  //   DateTime dateOfBirth,
  //   String gender,
  //   String location,
  //   File? image,
  //   BuildContext context,
  // ) async {
  //   // Get a Firestore instance
  //   final firestore = FirebaseFirestore.instance;

  //   // Get a reference to the collection where you want to write the data
  //   final userCollectionRef = firestore.collection('users');

  //   // Check if user already exists
  //   QuerySnapshot querySnapshot = await userCollectionRef
  //       .where('Username', isEqualTo: username)
  //       .limit(1)
  //       .get();
  //   bool exists = querySnapshot.docs.isNotEmpty;
  //   DocumentReference userDocRef;

  //   if (exists) {
  //     // Get reference to the existing document
  //     userDocRef = querySnapshot.docs[0].reference;

  //     // Show confirmation dialog
  //     bool confirm = await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text("Update details?"),
  //           content: Text("Do you want to update your details?"),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text("No"),
  //               onPressed: () => Navigator.of(context).pop(false),
  //             ),
  //             TextButton(
  //               child: Text("Yes"),
  //               onPressed: () => Navigator.of(context).pop(true),
  //             ),
  //           ],
  //         );
  //       },
  //     );

  //     if (!confirm) {
  //       return;
  //     }
  //   } else {
  //     // Create new document with auto-generated ID
  //     userDocRef = userCollectionRef.doc();

  //     // Set username field to the document ID
  //     //username = userDocRef.id;
  //   }

  //   // Upload profile picture to Firebase Storage
  //   String? profilePicURL;
  //   if (image != null) {
  //     Reference firebaseStorageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('users')
  //         .child(userDocRef.id)
  //         .child('ProfilePic');
  //     UploadTask uploadTask = firebaseStorageRef.putFile(image);
  //     await uploadTask.whenComplete(() async {
  //       profilePicURL = await uploadTask.snapshot.ref.getDownloadURL();
  //       print('Profile picture uploaded to Firebase Storage');
  //     });
  //   }

  //   // Update existing or create new document
  //   Map<String, dynamic> userData = {
  //     'Username': username,
  //     'Bio': bio,
  //     'Full Name': fullName,
  //     'Phone Number': phoneNumber,
  //     'Qualification': qualification,
  //     'Date Of Birth': dateOfBirth,
  //     'Gender': gender,
  //     'Your Location': location,
  //   };
  //   if (profilePicURL != null) {
  //     userData['ProfilePic'] = profilePicURL;
  //   }

  //   await userDocRef.set(userData, SetOptions(merge: true));

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('User Data Updated'),
  //       content: Text('User data has been updated successfully'),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> sendUserData(
    String username,
    String bio,
    String fullName,
    String phoneNumber,
    String qualification,
    DateTime dateOfBirth,
    String gender,
    String location,
    bool isPaidUser,
    File? image,
    BuildContext context,
  ) async {
    // Get a Firestore instance
    final firestore = FirebaseFirestore.instance;

    // Get a reference to the document where you want to write the data
    final userDocRef = firestore.collection('users').doc(widget.uid);

    // Check if user already exists
    DocumentSnapshot doc = await userDocRef.get();
    if (doc.exists) {
      // Show confirmation dialog
      bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update details?"),
            content: Text("Do you want to update your details?"),
            actions: <Widget>[
              TextButton(
                child: Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (confirm) {
        // Upload profile picture to Firebase Storage
        String? profilePicURL;
        if (image != null) {
          Reference firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('users')
              .child(widget.uid)
              .child('ProfilePic');
          UploadTask uploadTask = firebaseStorageRef.putFile(image);
          await uploadTask.whenComplete(() async {
            profilePicURL = await uploadTask.snapshot.ref.getDownloadURL();
            print('Profile picture uploaded to Firebase Storage');
          });
        }

        // Update existing document
        Map<String, dynamic> updatedData = {
          'Bio': bio,
          'Full Name': fullName,
          'Phone Number': phoneNumber,
          'Qualification': qualification,
          'Date Of Birth': dateOfBirth,
          'Gender': gender,
          'Your Location': location,
        };
        if (profilePicURL != null) {
          updatedData['ProfilePic'] = profilePicURL;
        }
        await userDocRef.update(updatedData);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('User Updated Successfully'),
            content: Text('User $username has been updated successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    } else {
      // Create new document
      // Upload profile picture to Firebase Storage
      String? profilePicURL;
      if (image != null) {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('users')
            .child(widget.uid)
            .child('ProfilePic');
        UploadTask uploadTask = firebaseStorageRef.putFile(image);
        await uploadTask.whenComplete(() async {
          profilePicURL = await uploadTask.snapshot.ref.getDownloadURL();
          print('Profile picture uploaded to Firebase Storage');
        });
      }

      // Update existing document
      Map<String, dynamic> userData = {
        'Username': username,
        'Bio': bio,
        'Full Name': fullName,
        'Phone Number': phoneNumber,
        'Qualification': qualification,
        'Date Of Birth': dateOfBirth,
        'Gender': gender,
        'Your Location': location,
        'Paid User': isPaidUser,
      };
      if (profilePicURL != null) {
        userData['ProfilePic'] = profilePicURL;
      }

// // Add image to Firebase Storage and get download URL
//       if (image != null) {
//         // Upload image to Firebase Storage
//         String imageName = username + '-profilePic';
//         Reference firebaseStorageRef =
//             FirebaseStorage.instance.ref().child('ProfilePics/$imageName');
//         UploadTask uploadTask = firebaseStorageRef.putFile(image);

//         // Get download URL for the image
//         String downloadURL = await uploadTask.then(
//           (snapshot) => snapshot.ref.getDownloadURL(),
//         );

//         userData['ProfilePic'] = downloadURL;
//       }

// Update user document in Firestore with new data
      await userDocRef.set(userData, SetOptions(merge: true));

// Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('User Data Updated'),
          content: Text('User $username data has been updated successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }

  TextEditingController _dateController = TextEditingController();
  TextEditingController _locController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    double baseWidth = 428;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    //String initialCountry = 'IN';

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
                                controller_ph = number.phoneNumber.toString();
                                print('Phone number: $controller_ph');
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              //textFieldController: controller_ph,
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
                                value: _dropdownValue,
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
                                    _dropdownValue = newValue!;
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
                          18 * fem, 12 * fem, 18 * fem, 10 * fem),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 1.91 * fem),
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
                            Container(
                              width: 1 * fem,
                              height: 1 * fem,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // group167ua (40:7643)
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 12 * fem, 18 * fem, 10 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffa8a8a8)),
                        color: Color(0xff0a66c2),
                        borderRadius: BorderRadius.circular(8 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // vectorDxc (40:7640)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
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
                          Container(
                            width: 1 * fem,
                            height: 1 * fem,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          18 * fem, 27 * fem, 19 * fem, 0 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () async {
                              //i want to write a function to push all the textediting controller fields to a firebase document called users
                              // print(_username.text);
                              // print(_bio.text);
                              // print(_fullname.text);
                              // print(controller_ph);
                              // print(_qualification.text);
                              // print(new DateFormat('dd/MM/yyyy')
                              //     .parse(_dateController.text));
                              // print(_dropdownValue);
                              // print(_locController.text);
                              await sendUserData(
                                _username.text,
                                _bio.text,
                                _fullname.text,
                                controller_ph,
                                _qualification.text,
                                new DateFormat('dd/MM/yyyy')
                                    .parse(_dateController.text),
                                _dropdownValue,
                                _locController.text,
                                isPaidUser,
                                image,
                                context,
                              );
                            },
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
            controller: type == 'Bio'
                ? _bio
                : type == 'Username'
                    ? _username
                    : type == 'Full Name'
                        ? _fullname
                        : _qualification,
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
