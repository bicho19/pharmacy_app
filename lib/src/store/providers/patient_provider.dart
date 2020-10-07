import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/models/patient.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class PatientProvider with ChangeNotifier {
  DBProvider _dbProvider;
  List<Patient> patientList = [];


  init() async {
    print("Init PatientProvider ...");
    _dbProvider = DBProvider.db;
    await getAllPatients();
  }

  Future<void> getAllPatients() async {
    final database = await _dbProvider.database;
    final results = await database.query(DBProvider.PATIENT_TABLE);
    if (results.length > 0){
      debugPrint("There are some patients");
      debugPrint(results.length.toString());
      patientList = List.generate(results.length, (index) => Patient.fromMap(results[index]));
      notifyListeners();
    } else {
      debugPrint("There is NO patients");
    }
  }

  Future<bool> insertPatient(Patient patient) async {
    bool inserted = false;
    final database = await _dbProvider.database;
    final result = await database.insert(DBProvider.PATIENT_TABLE, patient.saveToJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    if (result > 0) {
      print("Patient Inserted with ID $result");
      inserted = true;
      Patient patient = await getPatientByID(result);
      patientList.add(patient);
      notifyListeners();
    }
    return inserted;
  }

  Future<Patient> getPatientByID(int id) async {
    Patient patient;
    final database = await _dbProvider.database;
    final results = await database.query(
        DBProvider.PATIENT_TABLE, where: "pat_id = ?", whereArgs: [id], limit: 1);

    if (results.length > 0) {
      //patient fetched
      patient = Patient.fromMap(results[0]);
    }
    return patient;
  }


}