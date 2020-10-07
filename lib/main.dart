import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/screens/login_screen.dart';
import 'package:pharmacy_app/src/store/store.dart';
import 'package:pharmacy_app/src/utils/database_provider.dart';

Future<void> main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  DBProvider dbProvider = DBProvider.db;
  await dbProvider.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'PharmApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
