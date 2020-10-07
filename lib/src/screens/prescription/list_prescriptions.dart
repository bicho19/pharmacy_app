import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/screens/prescription/add_pescription_page.dart';
import 'package:pharmacy_app/src/screens/prescription/prescrtiption_info_card.dart';
import 'package:pharmacy_app/src/screens/prescription/print_prescriptions.dart';
import 'package:pharmacy_app/src/store/providers/prescription_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:provider/provider.dart';

class ListPrescriptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.scaffoldBackground,
      appBar: AppBar(
        title: Text("Prescription"),
        centerTitle: true,
        backgroundColor: Config.scaffoldBackground,
        elevation: 0,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PrintPrescriptionPage(listPrescription: context.read<PrescriptionProvider>().prescriptionList,),
                  ),
                ),
                child: Icon(
                  Icons.send,
                  size: 26.0,
                ),
              ),),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Config.scaffoldDark,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddPrescriptionPage()),
        ),
      ),
      body: context.watch<PrescriptionProvider>().prescriptionList.length == 0
          ? Center(
              child: Text(
                "There is no prescription in the database",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount:
                  context.watch<PrescriptionProvider>().prescriptionList.length,
              separatorBuilder: (_, index) => SizedBox(
                height: 12,
              ),
              itemBuilder: (_, position) {
                return PrescriptionInfoCard(
                  prescription: context
                      .read<PrescriptionProvider>()
                      .prescriptionList[position],
                );
              },
            ),
    );
  }
}
