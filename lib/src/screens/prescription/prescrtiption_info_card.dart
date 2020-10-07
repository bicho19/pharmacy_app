import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/src/store/models/prescription.dart';
import 'package:pharmacy_app/src/utils/config.dart';

class PrescriptionInfoCard extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionInfoCard({Key key, @required this.prescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: new BoxDecoration(
        color: Config.itemsBackground,
        borderRadius: new BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
            ),
            child: Icon(
              Icons.person_outline,
              color: Config.itemsBackground,
              size: 32,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Le: "+DateFormat("dd/MM/yyyy - hh:mm:ss")
                      .format(prescription.createdAt),
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 14, color: Colors.white70)),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Patient : ${prescription.patient?.name}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Medicament : ${prescription.medicament?.name}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(details.globalPosition, context);
            },
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset, BuildContext context) async {
    double left = offset.dx;
    double top = offset.dy;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
          child: const Text('Edit'),
          value: 'edit',
        ),
        PopupMenuItem<String>(child: const Text('Delete'), value: 'delete'),
      ],
      elevation: 8.0,
    ).then(
      (value) {
        if (value == "edit") {
          //User pressed on edit choice
          print("Editing patient ...");
          //_showEditMenu(context);
        } else if (value == "delete") {
          //User pressed on edit choice
          print("Editing patient ...");
          _showDeleteConfirmation(context);
        }
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          content: Container(
              height: 70,
              child: Center(
                  child: Text("Do you want to delete this prescription ?"))),
          actions: [
            //todo : implement edit from Database
            FlatButton(
                onPressed: () {},
                child: Text(
                  "Yes",
                  style: TextStyle(color: Colors.red, fontSize: 17),
                )),
            FlatButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                "No",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        );
      },
    );
  }
}
