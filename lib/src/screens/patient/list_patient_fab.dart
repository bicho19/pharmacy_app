import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/src/store/models/patient.dart';
import 'package:pharmacy_app/src/store/providers/patient_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:provider/provider.dart';

class ListPatientsFAB extends StatefulWidget {
  ListPatientsFAB({Key key}) : super(key: key);

  @override
  ListPatientsFABState createState() => ListPatientsFABState();
}

class ListPatientsFABState extends State<ListPatientsFAB> {
  bool isBottomModelOpened = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (!isBottomModelOpened)
          onFABpressed(context, null);
        else {
          Navigator.of(context).pop();
          isBottomModelOpened = false;
          setState(() {});
        }
      },
      child: isBottomModelOpened ? Icon(Icons.close) : Icon(Icons.add),
      backgroundColor: Config.scaffoldDark,
    );
  }

  void onFABpressed(BuildContext context, Patient patient) {
    if (!isBottomModelOpened) {
      TextEditingController _nameController = TextEditingController();
      TextEditingController _heightController = TextEditingController();
      TextEditingController _weightController = TextEditingController();
      TextEditingController _surfaceController = TextEditingController();
      bool isUpdate = false;

      //if patient is not null, fill the information
      if (patient != null) {
        isUpdate = true;
        _nameController.text = patient.name;
        _heightController.text = patient.height.toString();
        _weightController.text = patient.weight.toString();
        _surfaceController.text = patient.surface.toString();
      }

      isBottomModelOpened = true;
      Scaffold.of(context).showBottomSheet(
        (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  Text(
                    "Patient Information",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _nameController,
                      onSaved: (value) => _nameController.text = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Full Name",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _heightController,
                      onSaved: (value) => _heightController.text = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Height",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _weightController,
                      onSaved: (value) => _weightController.text = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Weight",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _surfaceController,
                      onSaved: (value) => _surfaceController.text = value,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Surface",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    height: 70,
                    child: RaisedButton(
                      onPressed: () async {
                        print("Submit from fab widget");
                        //Checking entered data;
                        _formKey.currentState.save();
                        if (_nameController.text.length > 4 &&
                            double.parse(_heightController.text) > 1.4 &&
                            double.parse(_weightController.text) > 50 &&
                            double.parse(_surfaceController.text) > 1) {
                          //Data is good
                          if (isUpdate) {
                          } else {
                            //Insert new patient
                            bool inserted = await context
                                .read<PatientProvider>()
                                .insertPatient(
                                  Patient(
                                      name: _nameController.text,
                                      weight:
                                          double.parse(_weightController.text),
                                      height:
                                          double.parse(_heightController.text),
                                      surface: double.parse(
                                          _surfaceController.text)),
                                );
                            if (inserted){
                              Navigator.of(context).pop();
                              isBottomModelOpened = false;
                              setState(() {});
                            }
                          }
                        }
                      },
                      child: Text(
                        isUpdate ? "Update" : "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: GoogleFonts.poppins().fontFamily),
                      ),
                      color: Config.itemsBackground,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.grey.shade200,
        elevation: 4,
        shape: RoundedRectangleBorder(),
      );
      setState(() {});
    }
  }
}
