import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/screens/medicaments/list_medicaments_fab.dart';
import 'package:pharmacy_app/src/screens/medicaments/medicament_info_card.dart';
import 'package:pharmacy_app/src/screens/medicaments/pdf_name.dart';
import 'package:pharmacy_app/src/store/providers/medicament_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:pharmacy_app/src/utils/widgets_keys.dart';
import 'package:provider/provider.dart';

class ListMedicaments extends StatefulWidget {
  @override
  _ListMedicamentsState createState() => _ListMedicamentsState();
}

class _ListMedicamentsState extends State<ListMedicaments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.scaffoldBackground,
      appBar: AppBar(
        title: Text("Medicaments"),
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
                    builder: (_) => Nam(listMedicament: context.read<MedicamentProvider>().medicamentList,),
                  ),
                ),
                child: Icon(
                  Icons.send,
                  size: 26.0,
                ),
              )),
        ],
      ),
      floatingActionButton: ListMedicamentsFAB(
        key: WidgetKeys.listMedicamentFABkey,
      ),
      body: context.watch<MedicamentProvider>().medicamentList.length == 0
          ? Center(
              child: Text(
                "There is no medicament in the database",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(16),
              itemCount:
                  context.watch<MedicamentProvider>().medicamentList.length,
              separatorBuilder: (_, index) => SizedBox(
                height: 12,
              ),
              itemBuilder: (_, position) {
                return MedicamentInfoCard(
                  medicament: context
                      .read<MedicamentProvider>()
                      .medicamentList[position],
                );
              },
            ),
    );
  }
}
