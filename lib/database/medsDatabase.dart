import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:meditime/database/tableConstants.dart';

class MedsDatabase{

  static final _dbName = "medsDB.db";
  static final _dbVersion = 1;

  MedsDatabase._privateConstructor();
  static final MedsDatabase instance = MedsDatabase._privateConstructor();

  static Database _database;

  Future<Database> get database  async{
    if(_database != null) return _database;

    _database = await _initialiseDatabase();
    return _database;
  }

  Future<Database> _initialiseDatabase() async{
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, _dbName);
    return await openDatabase(path,version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE ${MedsTableConstants.TABLE_NAME} (
        ${MedsTableConstants.COL_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MedsTableConstants.COL_NAME} TEXT NOT NULL,
        ${MedsTableConstants.COL_TYPE} TEXT NOT NULL,
        ${MedsTableConstants.COL_AMOUNT} INTEGER NOT NULL,
        ${MedsTableConstants.COL_UNITS} TEXT NOT NULL,
        ${MedsTableConstants.COL_DESCRIPTION} TEXT,
        ${MedsTableConstants.COL_TIMES_A_DAY} TEXT NOT NULL,
        ${MedsTableConstants.COL_INTERVAL} TEXT NOT NULL,
        ${MedsTableConstants.COL_FROM_DATE} TEXT NOT NULL,
        ${MedsTableConstants.COL_TO_DATE} TEXT NOT NULL
      )
    ''');
  }

}