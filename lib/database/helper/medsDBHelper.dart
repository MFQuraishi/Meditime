import 'package:meditime/database/medsDatabase.dart';
import 'package:meditime/database/tableConstants.dart';
import 'package:sqflite/sqflite.dart';

class MedsDBHelper{

  Future<int> create(map) async{
    Database db = await MedsDatabase.instance.database;
    var result = await db.insert("guestTable", map);
    return result;
  }

  Future<List> selectAll() async{
    Database db = await MedsDatabase.instance.database;
    var result = db.query("guestTable");
    return result;
  }

  Future<List> selectAtId(id) async{
    Database db = await MedsDatabase.instance.database;
    var result = db.query("guestTable", where: '_id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteRow(id) async {
    Database db = await MedsDatabase.instance.database;
    return db.delete("guestTable", where: '_id=?', whereArgs: [id]);
  }

}