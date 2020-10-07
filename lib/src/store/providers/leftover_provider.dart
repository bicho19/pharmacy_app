import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/models/leftover.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';

class LeftOverProvider with ChangeNotifier {
  DBProvider _dbProvider;
  List<LeftOver> leftOverList = [];

  init() async {
    print("Init LeftOverProvider ...");
    _dbProvider = DBProvider.db;
    await getAllLeftOvers();
  }

  Future<void> getAllLeftOvers() async {
    final database = await _dbProvider.database;
    final results = await database.query(DBProvider.LEFTOVER_TABLE);
    if (results.length > 0) {
      debugPrint("There are some leftovers");
      debugPrint(results.length.toString());
      leftOverList = List.generate(
          results.length, (index) => LeftOver.fromMap(results[index]));
      notifyListeners();
    } else {
      debugPrint("There is NO leftover");
    }
  }

  Future<LeftOver> getLeftoverOfMedicament({@required int medID}) async {
    final database = await _dbProvider.database;
    LeftOver leftOver;
    final results = await database.query(
      DBProvider.LEFTOVER_TABLE,
      where: "medicament_id = ?",
      whereArgs: [medID],
    );
    if (results.length > 0) {
      debugPrint("Found leftover of medicine with ID = ${medID.toString()}");
      debugPrint(results.length.toString());
      leftOver = LeftOver.fromMap(results[0]);
    } else {
      debugPrint("There is NO leftover");
    }
    return leftOver;
  }

  Future<void> deleteLeftOver({int id}) async {
    final database = await _dbProvider.database;
    final int result = await database
        .delete(DBProvider.LEFTOVER_TABLE, where: "leftover_id = ?", whereArgs: [id]);
    if (result > 0) {
      print("LeftOver with ID === $id has been deleted");
      return;
    }
  }

  Future<void> updateLeftOver({LeftOver leftover}) async {
    final database = await _dbProvider.database;
    final results = await database.update(
      DBProvider.LEFTOVER_TABLE,
      leftover.updateReliquat(),
      where: "leftover_id = ?",
      whereArgs: [leftover.id],
    );
    if (results > 0){
      print("LeftOver with ID ${leftover.id} \n new reliquat ");
    }
  }

  Future<void> insertLeftOver({LeftOver leftover}) async {
    final database = await _dbProvider.database;
    final results = await database.insert(
      DBProvider.LEFTOVER_TABLE,
      leftover.toMap(),
    );
    if (results > 0){
      print("LeftOver with ID $results inserted \n ");
    }
  }
}
