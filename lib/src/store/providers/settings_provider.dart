import 'package:flutter/foundation.dart';

class SettingsProvider with ChangeNotifier {
  String pharmacyName;
  String address;
  String phoneNumber;
  String email;
  String faxNumber;


  init() async {
    this.pharmacyName = "Pharmacy Elbez";
    this.address = "86 Rue Elbez, Setif. 19000";
    this.phoneNumber = "036454545";
    this.email = "phar.elbez@gmail.com";
    this.faxNumber = "036454545";
  }


}
