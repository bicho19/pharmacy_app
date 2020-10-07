import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/src/store/models/medicament.dart';
import 'package:pharmacy_app/src/store/providers/medicament_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:provider/provider.dart';

class ListMedicamentsFAB extends StatefulWidget {
  ListMedicamentsFAB({@required Key key}) : super(key: key);

  @override
  ListMedicamentsFABState createState() => ListMedicamentsFABState();
}

class ListMedicamentsFABState extends State<ListMedicamentsFAB> {
  bool isBottomModelOpened = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (!isBottomModelOpened)
          onMeddicamentFABpressed(context, null);
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

  void onMeddicamentFABpressed(BuildContext context, Medicament medicament) {
    if (!isBottomModelOpened) {
      TextEditingController _nameController = TextEditingController();
      TextEditingController _laboController = TextEditingController();
      TextEditingController _presContoller=TextEditingController();
      TextEditingController _ciController= TextEditingController();
      TextEditingController _cmnConroller=TextEditingController();
      TextEditingController _cmxController=TextEditingController();
      TextEditingController _volController=TextEditingController();
      TextEditingController _prixController=TextEditingController();
      TextEditingController _staController=TextEditingController();

      bool isUpdate = false;
      //if patient is not null, fill the information
      if (medicament != null) {
        isUpdate = true;
        _nameController.text = medicament.name;
        _laboController.text = medicament.labo;
        _presContoller.text = medicament.presentation.toString();
        _ciController.text = medicament.cinitial.toString();
        _cmnConroller.text = medicament.cmin.toString();
        _cmxController.text = medicament.cmax.toString();
        _volController.text = medicament.volInitial.toString();
        _prixController.text = medicament.prix.toString();
        _staController.text = medicament.stab.toString();
      }

      //Show Bottom sheet
      isBottomModelOpened = true;
      Scaffold.of(context).showBottomSheet((context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
          child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  "Medicament Information",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name",
                      labelText: "Name",
                      hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _laboController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Labo",
                      labelText: "Labo",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),


                SizedBox(height: 10,),
                TextFormField(
                  controller: _presContoller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Presentation",
                      labelText: ' Presentation (mg)',
                      hintStyle: TextStyle(color: Colors.grey)
                  ,),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _ciController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Initial Concentration (mg/ml)",
                    labelText: ' Initial Concentration (mg/ml)',
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _cmnConroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Minimum Concentration (mg/ml)",
                    labelText: ' Minimum Concentration (mg/ml)',
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),

                ),

                SizedBox(height: 10,),
                TextFormField(
                  controller: _cmxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Maximum Concentration (mg/ml)",
                    labelText: ' Maximum Concentration (mg/ml)',
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _volController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Initial Volume (mg/ml)",
                    labelText: ' Initial Volume (mg/ml)',
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: _prixController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Mg Price",
                    labelText: "mg price (DA)",
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _staController ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Stability",
                    labelText: "Stability (hours)",
                    hintStyle: TextStyle(color: Colors.grey)
                    ,),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  height: 70,
                  child: RaisedButton(
                    onPressed: () async {
                      //Checking entered data;
                      if (_nameController.text.length >= 4 &&
                          _laboController.text.length >= 4 &&
                          double.parse(_presContoller.text) > 1 &&
                          double.parse(_ciController.text) > 1 &&
                          double.parse(_cmnConroller.text) > 1 &&
                          double.parse(_cmxController.text) > 1 &&
                          double.parse(_volController.text) > 1 &&
                          double.parse(_prixController.text) > 1 &&
                          double.parse(_staController.text) >= 1
                      ) {
                        print("Submit from fab widget");
                        //Data is good
                        if (isUpdate) {
                          //todo : do the update for God sake

                        } else {
                          //Insert new patient
                          print("inser medicament");
                          bool inserted = await context
                              .read<MedicamentProvider>()
                              .insertMedicament(
                            Medicament(
                                name: _nameController.text,
                                labo: _laboController.text,
                                cinitial: double.parse(_ciController.text.toString()),
                                date: DateTime.now().toIso8601String(),
                                presentation: double.parse(_presContoller.text.toString()),
                                cmax: double.parse(_cmxController.text.toString()),
                                cmin: double.parse(_cmnConroller.text.toString()),
                                volInitial: double.parse(_volController.text.toString()),
                                priority: 1,
                                prix: double.parse(_prixController.text.toString()),
                                stab: double.parse(_staController.text.toString()),
                                ),
                          );
                          if (inserted){
                            Navigator.of(context).pop();
                            isBottomModelOpened = false;
                            setState(() {});
                          }
                        }
                      } else {
                        print("Not All fields are filled");
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
