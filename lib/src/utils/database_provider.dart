import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  Database _database;

  DBProvider._();

  static final DBProvider db = DBProvider._();

  /***************
   * Tables
   */
  static final String CLIENT_TABLE = "client";
  static final String PATIENT_TABLE = "patients";
  static final String MEDICAMENT_TABLE = 'medicaments';
  static final String PRESCRIPTION_TABLE = 'prescription';
  static final String LEFTOVER_TABLE = 'leftover';


  //***********************************medicamen Table***************************
  String _colMedId = 'med_id';
  String _colName = 'med_name';
  String _colLabo = 'labo';
  String _colDate = 'med_date';
  String _colpres = 'pres';
  String _colpriority = "priority";
  String _colCInit = 'cinit';
  String _colCmin = 'cmin';
  String _colCmax = 'cmax';
  String _colvol = 'vol';
  String _colprix = 'prix';
  String _colsta = 'stab';
//******************************************************************************
  //**********************************Table ordonnance***************************//

  String _ordonnace_colid = 'pres_id';
  String _ordonnace_colDate = 'pres_createdAt';
  String _ordonnace_colReduction = 'reduction';
  String _ordonnace_colPosologie = 'posologie';
  String _ordonnace_colMedicament = "medicament_id";
  String _ordonnace_colPatient = "patient_id";
  String _ordonnace_coldosage = 'dosage';
  String _ordonnace_colvolum_a_adminitrer = 'volum_a_administrer';
  String _ordonnace_type_poche = 'type_poche';

  //*************************************************************************************

  //************************************************ table leftover *********************
  String _lefteover_colid = 'leftover_id';
  String _lefteover_colDate = 'leftover_creadtedAt';
  String _lefteover_colMedicament = "medicament_id";
  String _lefteover_colordonance = "prescription_id";
  String _lefteover_colreliquat = 'reliquat';
  //*************************************************************************************



  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    print("InitDB...");
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "pharma.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: _onCreateDb, onConfigure: _onConfigure);
  }

  void _onCreateDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $CLIENT_TABLE ("
        "id INTEGER PRIMARY KEY,"
        "full_name TEXT,"
        "username TEXT,"
        "password TEXT"
        ")");
    await db.insert(CLIENT_TABLE, {
      "full_name": "Bicho",
      "username": "bicho19",
      "password": "wqxscv19"
    });
    await db.execute("CREATE TABLE $PATIENT_TABLE ("
        "pat_id INTEGER PRIMARY KEY,"
        "full_name TEXT,"
        "height REAL,"
        "weight REAL,"
        "surface REAL"
        ")");
    await db.insert(
      PATIENT_TABLE,
      {
        "full_name": "Hachemi",
        "height": 1.90,
        "weight": 94,
        "surface": 2,
      },
    );
    //************************************ CREATE TABLE medicine****************************************************
    await db.execute(
      'CREATE TABLE $MEDICAMENT_TABLE($_colMedId INTEGER PRIMARY KEY AUTOINCREMENT, $_colName TEXT, '
          '$_colLabo TEXT, $_colpres INTEGER, $_colDate TEXT, $_colpriority INT,$_colCInit INT,'
          '$_colCmin INT,$_colCmax INT,$_colvol INT,$_colprix INT,$_colsta INT)',
    );
    //*************************************************************************************************************

    //************************************************CREATE TABLE ORDONNANCE **************************************
    /*
    ArtistId INTEGER NOT NULL,
  FOREIGN KEY(ArtistId) REFERENCES Artists(ArtistId)
     */
    await db.execute(
      'CREATE TABLE $PRESCRIPTION_TABLE ('
          '$_ordonnace_colid INTEGER PRIMARY KEY AUTOINCREMENT, $_ordonnace_colReduction INTEGER, '
          '$_ordonnace_colPosologie INTEGER, $_ordonnace_colDate TEXT, '
          '$_ordonnace_colPatient INTEGER NOT NULL, $_ordonnace_colMedicament INTEGER NOT NULL, '
          '$_ordonnace_coldosage INTEGER, $_ordonnace_colvolum_a_adminitrer INTEGER, '
          '$_ordonnace_type_poche INTEGER, '//jed virgule radi rani sure
          'FOREIGN KEY($_ordonnace_colMedicament) REFERENCES $MEDICAMENT_TABLE($_colMedId) ON DELETE CASCADE, '
          'FOREIGN KEY($_ordonnace_colPatient) REFERENCES $PATIENT_TABLE(pat_id) ON DELETE CASCADE'
          ')'
      ,
    );

//*********************************************create table leftover***********************************************
    await db.execute(
      'CREATE TABLE $LEFTOVER_TABLE ('
          '$_lefteover_colid INTEGER PRIMARY KEY AUTOINCREMENT, '
          ' $_lefteover_colDate TEXT, '
          ' $_lefteover_colreliquat INTEGER, '
          ' $_lefteover_colMedicament INTEGER NOT NULL, '
          ' $_lefteover_colordonance INTEGER NOT NULL, '
          'FOREIGN KEY($_ordonnace_colMedicament) REFERENCES $MEDICAMENT_TABLE($_colMedId), '
          'FOREIGN KEY($_lefteover_colordonance) REFERENCES $PRESCRIPTION_TABLE($_ordonnace_colid) ON DELETE CASCADE'
          ')'
      ,
    );
    //**********************************************************************************************************

  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
