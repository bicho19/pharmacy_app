import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/models/client.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';

class AuthProvider with ChangeNotifier {
  Client client;
  DBProvider _dbProvider;

  init() async {
    client = Client();
    _dbProvider = DBProvider.db;
  }

  Future<bool> loginClient({String username, String password}) async {
    bool loggedIn = false;
    final database = await _dbProvider.database;
    List<Map<String, dynamic>> results = await database.query(
      DBProvider.CLIENT_TABLE,
      where: "username = ? and password = ?",
      whereArgs: [username, password],
      limit: 1,
    );
    if (results.length > 0){
      client = Client.fromMap(results[0]);
      debugPrint("Results is good");
      debugPrint(results[0].toString());
      debugPrint(client.fullName.toString());
      loggedIn = true;
      notifyListeners();
    }else {
      loggedIn = false;
    }
    return loggedIn;
  }
}
