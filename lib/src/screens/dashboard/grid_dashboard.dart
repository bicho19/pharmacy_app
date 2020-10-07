import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/src/screens/leftover/leftover_list_page.dart';
import 'package:pharmacy_app/src/screens/medicaments/list_medicaments.dart';
import 'package:pharmacy_app/src/screens/patient/list_patients.dart';
import 'package:pharmacy_app/src/screens/prescription/list_prescriptions.dart';
import 'package:pharmacy_app/src/screens/settings/setting_page.dart';
import 'package:pharmacy_app/src/store/providers/patient_provider.dart';
import 'package:sqlite_viewer/sqlite_viewer.dart';
import 'package:provider/provider.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboardState createState() => _GridDashboardState();
}

class _GridDashboardState extends State<GridDashboard> {
  Items patientItem;

  Items item2 = new Items(
    title: "Medicaments",
    subtitle: "list of all medicaments",
    event: "0 medicaments",
    destination: ListMedicaments(),
    img: "assets/icons/drug.svg",
  );

  Items item3 = new Items(
    title: "Prescription",
    subtitle: "add, remove prescription",
    event: "",
    destination: ListPrescriptions(),
    img: "assets/icons/hospital.svg",
  );

  Items item4 = new Items(
    title: "Leftovers",
    subtitle: "Rose favirited your Post",
    event: "",
    destination: LeftoverListPage(),
    img: "assets/icons/inventory.svg",
  );

  Items item5 = new Items(
    title: "Database Viewer",
    subtitle: "view data inside database",
    event: "",
    destination: DatabaseList(),
    img: "assets/icons/settings.svg",
  );

  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    // destination: SettingPage(),
    destination: SettingPage(),
    img: "assets/icons/settings.svg",
  );

  PatientProvider _patientProvider;

  @override
  Widget build(BuildContext context) {
    _patientProvider = Provider.of<PatientProvider>(context);
    patientItem = Items(
        title: "Patients",
        subtitle: "list of all patients",
        event: "${_patientProvider.patientList.length} Patient",
        destination: ListPatients(),
        img: "assets/icons/patient.svg");
    List<Items> myList = [patientItem, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          physics: NeverScrollableScrollPhysics(),
          children: myList.map((data) {
            return GestureDetector(
              onTap: data.destination != null
                  ? () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => data.destination))
                  : () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      data.img,
                      width: 42,
                      height: 60,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Widget destination;

  Items({this.title, this.subtitle, this.event, this.img, this.destination});
}
