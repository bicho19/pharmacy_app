import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/models/prescription.dart';
import 'package:pharmacy_app/src/utils/config.dart';

class ShowPrescription extends StatelessWidget {
  final Prescription prescription;

  const ShowPrescription({Key key, @required this.prescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription"),
        backgroundColor: Config.itemsBackground,
      ),
    );
  }
}
