import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/models/medicament.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class MedicamentProvider with ChangeNotifier {

  DBProvider _dbProvider;
  List<Medicament> medicamentList = [];


  init() async {
    print("Init PatientProvider ...");
    _dbProvider = DBProvider.db;
    await getAllMedicaments();
  }



  Future<void> getAllMedicaments() async {
    final database = await _dbProvider.database;
    final results = await database.query(DBProvider.MEDICAMENT_TABLE);
    if (results.length > 0){
      debugPrint("There are medicamets");
      debugPrint(results.length.toString());
      medicamentList = List.generate(results.length, (index) => Medicament.fromMap(results[index]));
      notifyListeners();
    } else {
      debugPrint("There is NO medicamets");
    }
  }

  Future<bool> insertMedicament(Medicament medicament) async {
    bool inserted = false;
    final database = await _dbProvider.database;
    final result = await database.insert(DBProvider.MEDICAMENT_TABLE, medicament.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    if (result > 0) {
      print("Medicament Inserted with ID $result");
      inserted = true;
      Medicament insertedMEd = await getMedicamentByID(result);
      medicamentList.add(insertedMEd);
      notifyListeners();
    }
    return inserted;
  }

  Future<Medicament> getMedicamentByID(int id) async {
    Medicament medicament;
    final database = await _dbProvider.database;
    final results = await database.query(
        DBProvider.MEDICAMENT_TABLE, where: "med_id = ?", whereArgs: [id], limit: 1);
    if (results.length > 0) {
      //patient fetched
      medicament = Medicament.fromMap(results[0]);
    }
    return medicament;
  }
}