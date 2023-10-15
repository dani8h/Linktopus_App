import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/job_listing/jobsPage.dart';
import '../Widgets/custom_box.dart';

class JobPopup extends StatefulWidget {
  const JobPopup({super.key});

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
    "American Tourister",
  ];
  List<bool> isPressed = [];
  List<String> selectedCompanies = [];
  final TextEditingController searchController = TextEditingController();
  RangeValues selectedRangeValues = const RangeValues(100000, 4000000);
  Map<String, dynamic> res = {};
  @override
  void initState() {
    super.initState();
    setState(() {
      for (var element in companies) {
        isPressed.add(false);
      }
    });
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
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 8.0),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 16.0),
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
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
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
              const SizedBox(height: 16.0),
              Text(
                'Companies',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8.0),
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
                              if (selectedCompanies
                                  .contains(companies[index])) {
                                selectedCompanies.remove(companies[index]);
                              } else {
                                selectedCompanies.add(companies[index]);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Salar-o-meter',
                style: TextStyle(
                  fontSize: screenWidth * 0.052,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8.0),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xffEF5DA8),
                  inactiveTrackColor: Colors.white,
                  thumbColor: Colors.white,
                  overlayColor: const Color(0xffEF5DA8),
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 20.0),
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: const Color(0xffEF5DA8),
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Column(
                  children: [
                    RangeSlider(
                      values: selectedRangeValues,
                      min: 0,
                      max: 5000000,
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '50,00,000+',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    // res['Work Type'] = workTypes;
                    res['Location'] = searchController.text;
                    res['upper range'] = selectedRangeValues.end;
                    res['lower range'] = selectedRangeValues.start;
                    res['Companies'] = selectedCompanies;
                    print("Res : ");
                    print(res);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Jobs_page(res),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
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
