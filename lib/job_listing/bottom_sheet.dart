import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  List<Map<String, dynamic>> _items = [];
  @override
  void initState() {
    super.initState();

    _items = List.generate(
      3,
      (index) {
        String title;
        String description;

        if (index == 0) {
          title = 'Job Description';
          description =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
        } else if (index == 1) {
          title = 'Minimum Qualifications';
          description =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
        } else {
          title = 'Preferred Qualifications';
          description =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
        }

        return {
          'id': index,
          'title': title,
          'description': description,
          'isExpanded': false,
        };
      },
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: size.height * 0.2,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          size: size.width * 0.12,
                          color: Colors.red,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senior Software Engineer',
                              style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Google LLP',
                              style: GoogleFonts.poppins(
                                  fontSize: size.width * 0.043,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'Bangalore, Karnataka(In-office)',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffA9A9A9),
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TagWidget('Top Rated', Icon(Icons.star)),
                        TagWidget('In Office', Icon(Icons.apartment)),
                        TagWidget('For You', Icon(Icons.favorite_outlined)),
                        TagWidget('Rupees', Icon(Icons.currency_rupee)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50),
                        child: expanel(),
                      ),
                      chooseresume(),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.03),
                        child: Card(
                          //color: Color(0xEED9D8D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                            child: GestureDetector(
                              onTap: () => null,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.1,
                                    vertical: size.height * 0.01),
                                child: Center(
                                  child: Text(
                                    'Apply Now',
                                    style: GoogleFonts.poppins(
                                      fontSize: size.width * 0.045,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget TagWidget(String str, Icon icn) {
    var size = MediaQuery.of(context).size;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.all(2),
        child: Center(
          child: Row(children: [icn, SizedBox(width: 0.1), Text(str)]),
        ),
      ),
    );
  }

  Widget expanel() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 3,
        // Controlling the expansion behavior
        expansionCallback: (index, isExpanded) {
          setState(() {
            _items[index]['isExpanded'] = !isExpanded;
          });
        },
        animationDuration: Duration(milliseconds: 600),
        children: _items
            .map(
              (item) => ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: item['isExpanded'] == true
                    ? Colors.grey[300]
                    : Colors.white,
                headerBuilder: (_, isExpanded) => Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.1),
                    child: Text(
                      item['title'],
                      style: TextStyle(fontSize: size.width * 0.035),
                    )),
                body: Container(
                  padding: EdgeInsets.only(
                      bottom: size.height * 0.03,
                      left: size.width * 0.1,
                      right: size.width * 0.1),
                  child: Text(item['description']),
                ),
                isExpanded: item['isExpanded'],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget chooseresume() {
    var size = MediaQuery.of(context).size;
    return Container(
      //height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 231, 229, 229),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
              child: Text(
                'Choose Your Resume',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            FutureBuilder<List<String>>(
              future: fetchResumes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('User not logged in');
                } else {
                  final resumes = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return resumecard(resumes![index], resumeUrls[index]);
                    },
                    itemCount: resumes?.length,
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Card(
                color: Color(0xff2B3688),
                elevation: 4,
                child: GestureDetector(
                  onTap: () => selectFile(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.005),
                    child: Center(
                      child: Text(
                        'Choose From Device',
                        style: GoogleFonts.poppins(
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> resumeUrls = [];

  Future<List<String>> fetchResumes() async {
    final User? user = auth.currentUser;
    final uid = user!.uid; // Replace with the actual user ID
    try {
      final storage = firebase_storage.FirebaseStorage.instance;
      final ListResult result = await storage.ref('users/$uid').listAll();
      final List<String> resumes = [];

      if (result.items.isEmpty) {
        return Future.error('User Not Logged In');
      }

      for (final ref in result.items) {
        if (ref.name != 'ProfilePic') {
          resumes.add(ref.name);
          final url = await ref.getDownloadURL();
          resumeUrls.add(url);
        }
      }

      return resumes;
    } catch (e) {
      return Future.error('User Not Logged In');
    }
  }

  bool isSelected = false; // New variable to track the card's selection state
  Widget resumecard(String resumeName, String resumeUrl) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        openPDF(resumeUrl);
      },
      onLongPress: () {
        setState(() {
          isSelected =
              !isSelected; // Set the selection state to true on long press
        });
      },
      child: Card(
        elevation: 3.0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Colors.black
                  : Colors.transparent, // Darken the border if selected
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
            child: Text(resumeName),
          ),
        ),
      ),
    );
  }

  void openPDF(String resumeUrl) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PDFViewerPage(url: resumeUrl)),
    );
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

      if (confirm) {}
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
}

class PDFViewerPage extends StatelessWidget {
  final String url;

  const PDFViewerPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.network(
        url,
        canShowPaginationDialog: true,
        pageSpacing: 4,
        onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
          print(details.description);
        },
      ),
    );
  }
}
