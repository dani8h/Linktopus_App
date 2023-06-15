import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet.dart';

class JobListings extends StatelessWidget {
  const JobListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Job Listings'),
        ),
        //backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: List.generate(10, (index) => JobCard(context)),
            ),
          ),
        ));
  }

  Widget JobCard(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Bottomsheet();
        },
      ),
      child: Card(
          elevation: 4.0,
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 130.0, vertical: 25.0),
            child: Text('Job Card'),
          )),
    );
  }
}
