import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

const GMAIL_SCHEMA = 'com.google.android.gm';

class Bottomsheet extends StatefulWidget {
  final dynamic jobdata;
  const Bottomsheet({super.key, required this.jobdata});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  int selectedCardIndex = -1;
  String? selectedCardName; // Variable to store the selected card's name
  String? selectedCardResumeUrl;
  String? selectedCardFilePath;

  Future<void> sendmail() async {
    final MailOptions mailOptions = MailOptions(
      subject:
          'Job Application : ${widget.jobdata.child('tags').value}-${widget.jobdata.child('Role').value}',
      isHTML: true,
      recipients: ['${widget.jobdata.child('Email').value}'],
      attachments: [
        selectedCardFilePath!,
      ],
      appSchema: GMAIL_SCHEMA,
    );
    String platformResponse;
    try {
      final MailerResponse response = await FlutterMailer.send(mailOptions);
      print("here");
      switch (response) {
        case MailerResponse.saved:
          platformResponse = 'mail was saved to draft';
          break;
        case MailerResponse.sent:
          platformResponse = 'mail was sent';
          break;
        case MailerResponse.cancelled:
          platformResponse = 'mail was cancelled';
          break;
        case MailerResponse.android:
          platformResponse = 'intent was success';
          break;
        default:
          platformResponse = 'unknown';
          break;
      }
    } catch (error) {
      platformResponse = error.toString();
    }
  }

  List<Map<String, dynamic>> _items = [];
  @override
  void initState() {
    super.initState();
    print('data is');
    print(widget.jobdata.value);
    _items = List.generate(
      2,
      (index) {
        String title;
        String description;

        if (index == 0) {
          title = 'Minimum Experience';
          description = widget.jobdata.child('Experience').value.toString();
        } else {
          title = 'Preferred Qualifications';
          description =
              widget.jobdata.child('Preferred Qualifications').value.toString();
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
    // Initialize to -1 (no card selected)
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
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
                padding: const EdgeInsets.all(10),
                height: size.height * 0.15,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                            radius: size.width * 0.1,
                            backgroundImage: widget.jobdata
                                        .child('Image')
                                        .value
                                        .toString() !=
                                    ""
                                ? NetworkImage(widget.jobdata
                                    .child('Image')
                                    .value
                                    .toString())
                                : NetworkImage(
                                    'https://www.searchenginejournal.com/wp-content/uploads/2017/06/shutterstock_268688447.jpg')),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.70,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  widget.jobdata
                                          .child('Profile')
                                          .value
                                          .toString() ??
                                      'NA',
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                widget.jobdata
                                        .child('Company')
                                        .value
                                        .toString() ??
                                    'NA',
                                style: GoogleFonts.poppins(
                                    fontSize: size.width * 0.043,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                widget.jobdata
                                        .child('Location')
                                        .value
                                        .toString() ??
                                    'NA',
                                style: GoogleFonts.poppins(
                                    color: const Color(0xffA9A9A9),
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.01,
              // ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1, vertical: 5),
                        child: Column(
                          children: [
                            Text(
                              'Job Description',
                              style: GoogleFonts.poppins(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.jobdata
                                      .child('Job Description')
                                      .value
                                      .toString() ??
                                  'NA',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
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
                              gradient: const LinearGradient(
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
                              onTap: () {
                                if (selectedCardName == null) {
                                  // Show a dialog when no file is selected
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('No File Selected'),
                                        content: const Text(
                                            'Please select a file before sending the email.'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return; // Exit the function if no file is selected
                                }
                                _downloadFileAndFetchPath(
                                    selectedCardResumeUrl!, selectedCardName!);

                                //now redirect to gmail using some plugin:
                                sendmail();
                              },
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

  // Widget TagWidget(String str, Icon icn) {
  //   var size = MediaQuery.of(context).size;
  //   return Material(
  //     elevation: 2,
  //     borderRadius: BorderRadius.circular(6),
  //     child: Container(
  //       padding: EdgeInsets.all(2),
  //       child: Center(
  //         child: Row(children: [icn, SizedBox(width: 0.1), Text(str)]),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _downloadFileAndFetchPath(String fileUrl, String title) async {
    try {
      // Download the file from the URL
      var response = await http.get(Uri.parse(fileUrl));

      // Get the temporary directory path on the device
      Directory tempDir = await getTemporaryDirectory();

      // Create a new file in the temporary directory
      File file = File('${tempDir.path}/$title.pdf');

      // Write the file content from the response body
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        selectedCardFilePath = file.path; // Save the local file path
      });
    } catch (e) {
      print('Error during file download: $e');
    }
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
        animationDuration: const Duration(milliseconds: 600),
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
                      style: GoogleFonts.poppins(fontSize: size.width * 0.035),
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
        color: const Color.fromARGB(255, 231, 229, 229),
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
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('User not logged in');
                } else {
                  final resumes = snapshot.data;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return resumecard(
                        resumes![index],
                        resumeUrls[index],
                        selectedCardIndex == index,
                        () => toggleCardSelection(
                            index, resumes[index], resumeUrls[index]),
                      );
                    },
                    itemCount: resumes?.length,
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Card(
                color: const Color(0xff2B3688),
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

  void toggleCardSelection(int index, String resumeName, String resumeUrl) {
    setState(() {
      selectedCardName = resumeName; // Store the selected card's name
      selectedCardResumeUrl = resumeUrl;
      selectedCardIndex = index; // Update the selected card index
    });
  }

  Widget resumecard(String resumeName, String resumeUrl, bool isSelected,
      Function() onLongPress) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        print(resumeUrl);
        openPDF(resumeUrl);
      },
      onLongPress: onLongPress,
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
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
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
            title: const Text("Upload file?"),
            content: Text("Do you want to upload $fileName?"),
            actions: <Widget>[
              TextButton(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    sendmail();
                    Navigator.of(context).pop(true);
                  }),
            ],
          );
        },
      );

      if (confirm) {
        selectedCardFilePath = file.path;
      }
    } else {
      // User canceled the file selection

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No file selected'),
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
        title: const Text('PDF Viewer'),
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
