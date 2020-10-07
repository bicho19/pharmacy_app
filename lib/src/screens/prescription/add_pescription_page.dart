import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_app/src/screens/prescription/show_prescription.dart';
import 'package:pharmacy_app/src/store/models/leftover.dart';
import 'package:pharmacy_app/src/store/models/medicament.dart';
import 'package:pharmacy_app/src/store/models/patient.dart';
import 'package:pharmacy_app/src/store/models/prescription.dart';
import 'package:pharmacy_app/src/store/providers/leftover_provider.dart';
import 'package:pharmacy_app/src/store/providers/medicament_provider.dart';
import 'package:pharmacy_app/src/store/providers/patient_provider.dart';
import 'package:pharmacy_app/src/store/providers/prescription_provider.dart';
import 'package:pharmacy_app/src/utils/config.dart';
import 'package:provider/provider.dart';

class AddPrescriptionPage extends StatefulWidget {
  @override
  _AddPrescriptionPageState createState() => _AddPrescriptionPageState();
}

class _AddPrescriptionPageState extends State<AddPrescriptionPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //Controllers - Textfields
  TextEditingController _laboController = TextEditingController();
  TextEditingController _presentationcontroller = TextEditingController();
  TextEditingController _posologieController = TextEditingController();
  TextEditingController _reductionController = TextEditingController(text: "1");
  TextEditingController _volumeFinaleController = TextEditingController();

  Prescription _prescription = Prescription();
  Patient selectedPatient;
  Medicament selectedMedicament;

  double volume;
  double newReliquat = 0.0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Add Prescription"),
        centerTitle: true,
        backgroundColor: Config.scaffoldBackground,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
        children: [
          DropdownSearch<Patient>(
            showSearchBox: true,
            isFilteredOnline: false,
            showSelectedItem: true,
            label: "Patient",
            mode: Mode.DIALOG,
            selectedItem: selectedPatient,
            onFind: (String filter) => getFilteredPatient(filter),
            itemAsString: (Patient patient) => patient.name,
            //build the value showed in the field
            // dropdownBuilder: (
            //     BuildContext context, Patient selectedItem, String itemAsString){
            //   return Text('Test');
            // },
            popupItemBuilder: (_, patient, selected){
              return ListTile(
                title: Container(color: Colors.indigoAccent.shade100, alignment: Alignment.centerLeft, height: 48, width: double.infinity, child: Text(patient.name, style: TextStyle(color: Colors.black),),),
              );
            },
            popupTitle: Container(padding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                child: Text("Select or search", style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),),
            onChanged: (Patient data) {
              setState(() {
                selectedPatient = data;
              });
            },
            compareFn: (Patient i, Patient s) => i.isEqual(s),
          ),
          SizedBox(height: 16),
          DropdownSearch<Medicament>(
            showSearchBox: true,
            showSelectedItem: true,
            isFilteredOnline: false,
            label: "Medicament",
            selectedItem: selectedMedicament,
            mode: Mode.DIALOG,
            compareFn: (Medicament i, Medicament s) => i.isEqual(s),
            onFind: (String filter) => getFilteredMedicament(filter),
            itemAsString: (Medicament medecament) => medecament.name,
            popupItemBuilder: (_, medicament, bool selected){
              return ListTile(
                title: Container(color: selected ? Colors.indigoAccent.shade100 : Colors.white, alignment: Alignment.centerLeft, height: 48, width: double.infinity, child: Text(medicament.name, style: TextStyle(color: Colors.black),),),
              );
            },
            onChanged: (Medicament data) {
              setState(() {
                selectedMedicament = data;
                _laboController.text = selectedMedicament.labo;
                _presentationcontroller.text =
                    selectedMedicament.presentation.toString();
              });
              //_calculate();
            },
          ),
          SizedBox(
            height: 16
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Laboratory",
              labelText: "Laboratory",
              border: OutlineInputBorder(),
            ),
            controller: _laboController,
            enabled: false,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Dosage mg/m2",
              labelText: "Doage mg/m2",
              border: OutlineInputBorder(),
            ),
            controller: _posologieController,
          ),
          SizedBox(
            height: 20
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Reduction",
              labelText: "Reduction",
              border: OutlineInputBorder(),
            ),
            controller: _reductionController,
          ),
          SizedBox(
            height: 20
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: " Final volum  ml",
                labelText: "Final volum  ml",
                border: OutlineInputBorder(),),
            controller: _volumeFinaleController,
            enabled: false,
          ),

          SizedBox(
            height: 48
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            height: 80,
            child: RaisedButton(
              onPressed: isLoading ? null : () async {
                _calculate();
              },
              child: isLoading ? CircularProgressIndicator(backgroundColor: Colors.white, ) : Text("Submit",
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
  }

  Future<List<Patient>> getFilteredPatient(String filter) {
    List<Patient> tempList = context
        .read<PatientProvider>()
        .patientList
        .where((element) => element.name.contains(filter))
        .toList();
    return Future.value(tempList);
  }

  Future<List<Medicament>> getFilteredMedicament(String filter) {
    List<Medicament> tempList = context
        .read<MedicamentProvider>()
        .medicamentList
        .where((element) => element.name.contains(filter))
        .toList();
    return Future.value(tempList);
  }

  Future<void> _calculate() async {
    if (selectedMedicament != null &&
        selectedPatient != null &&
        _posologieController.text.isNotEmpty &&
        _reductionController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      double dosage = selectedPatient.surface *
          (double.parse((_posologieController.text ?? 0))) *
          (double.parse((_reductionController.text ?? 0)));

      volume = dosage / selectedMedicament.cinitial;

      //Check if current medicament has an ACTIVE reliquat
      LeftOver leftOver = await context
          .read<LeftOverProvider>()
          .getLeftoverOfMedicament(medID: selectedMedicament.id);





      //
      if (leftOver != null){
        //There is a reliquat before
        if (leftOver.reliquat > 0) {
          if (leftOver.createdAt.add(Duration(hours: selectedMedicament.stab.toInt())).difference(DateTime.now()).isNegative) {
            //Reliquat is dead (périmé), we found a reliquat mayta lool
            print("######   -- MEDICAMENT HAS PREVIOUS REIQUAT ---- ### ");
            print(" ---- Reliquat is dead ---- ");
            print(
                "Reliqat Date : ${leftOver.createdAt.toIso8601String()} VS NOW ${DateTime.now()}");
            _calculeVolumeAndReliquat();
          } else {
            //current medicament 3ado reliquat w mahich dead
            print(
                "############################## MEDICAMENT HAS PREVIOUS REIQUAT #########################################");
            double _rest = volume - leftOver.reliquat;
            //check if the rest either >0 || ==0 || <0
            if (_rest > 0) {
              //mazal volume lazem nakhadmoh, y7al flacon jdod
              //reliquat dinaha kamla fassi gdima
              // delete old leftover
              await context
                  .read<LeftOverProvider>().deleteLeftOver(id: leftOver.id);
              print(" LE RESTE >>>>>> 0 ");
              scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("We will use ALL the reliquat")));
              volume = volume - leftOver.reliquat;
              _calculeVolumeAndReliquat();
            } else if (_rest == 0) {
              //reliquat tekfi bach nakhadmi volume hada
              //reliquat dinaha fassi gdima
              print("LE  RESTE  ===========0");
              scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("We will use ALL the reliquat, reste = 0 ")));
              //delete this leftover from database
              await context
                  .read<LeftOverProvider>().deleteLeftOver(id: leftOver.id);

            } else {
              // reliquat tekfi w tfadhel
              // dir update lel reliquat only, no date
              print("LE RESTE <<<<<<<<<<<  0 ");
              newReliquat = leftOver.reliquat - volume;
              //update reliquat in database;
              leftOver.reliquat = newReliquat;
              await context.read<LeftOverProvider>().updateLeftOver(leftover : leftOver);
            }
          }
        } else {
          //current medicament ma 3andouche reliqat
          print(
              "############################## MEDICAMENT HAS NO NO NO PREVIOUS REIQUAT #########################################");
          _calculeVolumeAndReliquat();
        }
      } else {
        //current medicament ma 3andouche reliqat
        print(
            "########### MEDICAMENT Leftover is null ##################\n\n\n");
        _calculeVolumeAndReliquat();
      }



      //Affichage du resultat dans les champs qui correspondant
      _volumeFinaleController.text = volume.toString();

      _prescription.dosage = dosage;
      _prescription.patient = selectedPatient;
      _prescription.medicament = selectedMedicament;
      _prescription.createdAt = DateTime.now();
      _prescription.posologie = double.parse(_posologieController.text);
      _prescription.reduction = int.parse(_reductionController.text);
      _prescription.volumeAadministrer = volume;


      print("######### ORDONANCE #######");
      print(_prescription.saveToMap());
      print("######### MEDICAMENT #######");
      print(selectedMedicament.toMap());
      //Save the ordonance
      bool result = await context.read<PrescriptionProvider>().insertPrescription(_prescription);
      if (result){
        //new prescription has been inserted
        print("Yaay, prscription has been inserted ...");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowPrescription(prescription: _prescription),
          ),
        );
      } else {
        setState(() {
          isLoading = true;
        });
        print("\n \n \n \n \n Error happened while inserting prescription");
      }
    }
  }

  void _calculeVolumeAndReliquat() {
    //Calcule ta3 reliquat, tji after we check if there is some previous reliquat
    double reliquat = selectedMedicament.volInitial - volume;
    if (reliquat > 0) {
      print("Reliquat is >>> 0 ===> $reliquat +ml");
      //todo: mba3da naffichihom f showpage
      newReliquat = reliquat;
    } else {
      print("Reliquat is <<<< 0");
      double resultOf9isma = volume / selectedMedicament.volInitial;
      //print("reliquat dakheel  else is $reliquat");
      if ((resultOf9isma % 1) == 0) {
        // reliquat is an integer
        print("nombre de flacon utilisé $resultOf9isma");
        resultOf9isma = 0;
        print("Reliquat is $resultOf9isma");
      } else {
        double fraction = reliquat - reliquat.truncate();
        print("flacon $reliquat");
        //truncate() function for double type which returns the integer part discarding the fractional part.
        double tahwil = fraction * selectedMedicament.volInitial;
        reliquat = selectedMedicament.volInitial - tahwil;
        print("reliquat final $reliquat");

//        print("srface ${currentSelectedPatient.surface}");
//        print("c_minimal ${currentSelectedMedicament.cmn} ");
//        print("c_maximal ${currentSelectedMedicament.cmx}");
        print("tahwil $tahwil");
        print("vvol ${selectedMedicament.volInitial}");
      }

      newReliquat = reliquat;
    }

    if (volume >= selectedMedicament.cmin * 250 &&
        volume <= 250 * selectedMedicament.cmax) {
      print("use a serum bag of 250 ml");
      _prescription.type_poche = 250;
    } else if (volume >= selectedMedicament.cmin * 500 &&
        volume <= 500 * selectedMedicament.cmax) {
      print("use a serum bag of 500 ml");
      _prescription.type_poche = 500;
    } else {
      //Sinn
      _prescription.type_poche = 1000;
    }
  }
}
