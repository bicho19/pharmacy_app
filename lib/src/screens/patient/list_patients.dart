import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/src/screens/patient/list_patient_fab.dart';
import 'package:pharmacy_app/src/screens/patient/patient_info_card.dart';
import 'package:pharmacy_app/src/store/models/patient.dart';
import 'package:pharmacy_app/src/store/providers/patient_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:pharmacy_app/src/utils/widgets_keys.dart';
import 'package:provider/provider.dart';

class ListPatients extends StatefulWidget {
  @override
  _ListPatientsState createState() => _ListPatientsState();
}

class _ListPatientsState extends State<ListPatients> {
  PatientProvider _patientProvider;

  @override
  Widget build(BuildContext context) {
    _patientProvider = Provider.of<PatientProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Config.scaffoldBackground,
      appBar: AppBar(
        title: Text("Patients"),
        centerTitle: true,
        backgroundColor: Config.scaffoldBackground,
        elevation: 0,
      ),
      floatingActionButton: ListPatientsFAB(
        key: WidgetKeys.listPatientFABkey,
      ),
      body: _patientProvider.patientList.length == 0
          ? Center(
              child: Text(
                "There is no patient in the database",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount: _patientProvider.patientList.length,
              separatorBuilder: (_, index) => SizedBox(
                height: 12,
              ),
              itemBuilder: (_, position) {
                if (_patientProvider.patientList.length == 0)
                  return Center(
                    child: Text("There is no patient in the database"),
                  );
                return PatientInfoCard(
                  patient: _patientProvider.patientList[position],
                );
              },
            ),
    );
  }
}
