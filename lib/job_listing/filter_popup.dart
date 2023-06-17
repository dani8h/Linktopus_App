import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/Widgets/Customtextbox_widget.dart';
import '../Widgets/custom_box.dart';

class JobPopup extends StatefulWidget {
  @override
  _JobPopupState createState() => _JobPopupState();
}

class _JobPopupState extends State<JobPopup> {
  final List<String> companies = [
    "Google",
    "Deloitte",
    "Microsoft",
    "Adobe",
    "Hp",
    "TCS",
    "Bosch",
    "Hindustan Unilever",
    "American Tourister"
  ];
  List<bool> isPressed = [];
  List<String> selectedCompanies = [];
  final TextEditingController searchController = TextEditingController();
  int selectedCompanyIndex = 0;
  int selectedWorkType = 0;
  RangeValues selectedRangeValues = RangeValues(100000, 900000);

  @override
  void initState() {
    super.initState();
    setState(() {
      companies.forEach((element) {
        isPressed.add(false);
      });
    });
  }

//Container for work type
  Widget buildWorkTypeContainer(
      int index, String imagePath, String text, double screenWidth) {
    bool isSelected = selectedWorkType == index;
    Color borderColor = isSelected ? Colors.black : Colors.grey;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedWorkType = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Image.asset(imagePath),
              SizedBox(width: 3.0),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double popupWidth = screenWidth * 0.95;
    final double popupHeight = screenHeight * 0.6;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: (screenWidth - popupWidth) / 2,
        vertical: (screenHeight - popupHeight) / 2,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: popupWidth,
          height: popupHeight,
          padding: EdgeInsets.all(16.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.0),
              Divider(color: Colors.grey.shade800),
              SizedBox(height: 8.0),
              Text(
                'Work Type',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildWorkTypeContainer(
                      0,
                      'assets/images/office.png',
                      'In-Office',
                      screenWidth,
                    ),
                    buildWorkTypeContainer(
                      1,
                      'assets/images/home.png',
                      'Work from Home',
                      screenWidth,
                    ),
                    buildWorkTypeContainer(
                      2,
                      'assets/images/hybrid.png',
                      'Hybrid',
                      screenWidth,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: screenWidth * 0.052,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: screenWidth * 0.052,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Color(0xffABABAB),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFEF5DA8), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Companies',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 25.0, top: 8, bottom: 8),
                    child: Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      children: List.generate(
                        companies.length,
                        (index) => CustomTextbox2(
                          text: companies[index],
                          isPressed: isPressed[index],
                          onPressed: (isPressed) {
                            setState(() {
                              this.isPressed[index] = isPressed;
                              if (isPressed) {
                                selectedCompanyIndex = index;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Salar-o-meter',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 8.0),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Color(0xffEF5DA8),
                  inactiveTrackColor: Colors.white,
                  thumbColor: Colors.white,
                  overlayColor: Color(0xffEF5DA8),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Color(0xffEF5DA8),
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Column(
                  children: [
                    RangeSlider(
                      values: selectedRangeValues,
                      min: 0,
                      max: 1000000,
                      divisions: 10,
                      labels: RangeLabels(
                        selectedRangeValues.start.toString(),
                        selectedRangeValues.end.toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          selectedRangeValues = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '1,000,000+',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // Print selected options
                    print(
                        'Work Type: ${selectedWorkType != null ? selectedWorkType : ''}');
                    print('Location: ${searchController.text}');
                    print('Company: ${companies[selectedCompanyIndex]}');
                    print(
                        'Salary Range: ${selectedRangeValues.start} - ${selectedRangeValues.end}');
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment(
                              0.7424360513687134, 0.011676779016852379),
                          end: Alignment(
                              -0.011676778085529804, 0.015544017776846886),
                          colors: [
                            Color.fromRGBO(193, 30, 93, 1),
                            Color.fromRGBO(47, 54, 118, 1)
                          ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.white,
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
    );
  }
}
