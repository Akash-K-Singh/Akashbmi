import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mybmi/BmiDataModel.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, 'BmiDataModel.dart');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bmidata (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, weight INTEGER NOT NULL, feets INTEGER NOT NULL, inches INTEGER NOT NULL, bmiValue TEXT NOT NULL)");
  }

  Future<BmiDataModel> insert(BmiDataModel bmiDataModel) async {
    var dbClient = await db;
    await dbClient!.insert('bmidata', bmiDataModel.toMap());
    return bmiDataModel;
  }

  Future<List<BmiDataModel>> getBmiDataList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query(
      'bmidata',
      orderBy: 'date DESC',
    );
    return queryResult.map((e) => BmiDataModel.fromMap(e)).toList();
  }

  Future<int> doesDateExists(String date) async {
    var dbClient = await db;
    var result = await dbClient!
        .rawQuery("select id from bmidata where date = '${date}'");
    if (result.isNotEmpty) {
      return (int.parse(result[0].toString().substring(5, 7)));
    } else {
      return -1;
    }
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('bmidata', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(BmiDataModel bmiDataModel) async {
    var dbClient = await db;
    return await dbClient!.update('bmidata', bmiDataModel.toMap(),
        where: 'id = ?', whereArgs: [bmiDataModel.id]);
  }
}
