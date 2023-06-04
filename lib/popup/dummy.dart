import 'package:flutter/material.dart';
import './filter_popup.dart';

class Dummy extends StatelessWidget {
  const Dummy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return JobPopup();
              },
            );
          },
          child: Text('Open Popup'),
        ),
      ),
    );
  }
}
