import 'package:flutter/foundation.dart';
import 'package:pharmacy_app/src/store/models/prescription.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class PrescriptionProvider with ChangeNotifier{
  DBProvider _dbProvider;
  List<Prescription> prescriptionList = [];


  init() async {
    print("Init PrescriptionProvider ...");
    _dbProvider = DBProvider.db;
    await getAllPrescriptions();
  }

  Future<void> getAllPrescriptions() async {
    final database = await _dbProvider.database;
    final results = await database.rawQuery(""
        "select * from ${DBProvider.PRESCRIPTION_TABLE} pres "
        "INNER JOIN ${DBProvider.MEDICAMENT_TABLE} medicament ON "
        "pres.medicament_id == medicament.med_id "
        "INNER JOIN ${DBProvider.PATIENT_TABLE} patient ON "
        "pres.patient_id == patient.pat_id"
    );
    if (results.length > 0){
      debugPrint("There are some prescriptions");
      debugPrint(results.length.toString());
      prescriptionList = List.generate(results.length, (index) => Prescription.fromMap(results[index]));
      notifyListeners();
    } else {
      debugPrint("There is NO prescription");
    }
  }

  Future<bool> insertPrescription(Prescription nPrescription) async {
    bool inserted = false;
    final database = await _dbProvider.database;
    final result = await database.insert(DBProvider.PRESCRIPTION_TABLE, nPrescription.saveToMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    if (result > 0) {
      print("Prescription Inserted with ID $result");
      inserted = true;
      Prescription prescription = await getPrescriptionByID(result);
      if (prescription != null) prescriptionList.add(prescription);
      notifyListeners();
    }
    return inserted;
  }

  Future<Prescription> getPrescriptionByID(int id) async {
    Prescription prescription;
    final database = await _dbProvider.database;
    final results = await database.rawQuery(""
        "select * from ${DBProvider.PRESCRIPTION_TABLE} pres "
        "INNER JOIN ${DBProvider.MEDICAMENT_TABLE} medicament ON "
        "pres.medicament_id == medicament.med_id "
        "INNER JOIN ${DBProvider.PATIENT_TABLE} patient ON "
        "pres.patient_id == patient.pat_id "
        "where pres_id == $id "
        "limit 1", );

    if (results.length > 0) {
      //prescription fetched
      prescription = Prescription.fromMap(results[0]);
    }
    return prescription;
  }
}