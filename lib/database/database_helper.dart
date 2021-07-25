import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/model.dart';

class DBHelper {
  static const dbName = 'plan.db';
  static const table = 'Plan';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDate = 'date';

  DBHelper._();
  static final DBHelper instance = DBHelper._();
  factory DBHelper() => instance;
  static Database? database;

  Future<Database?> get getDatabase async {
    if (database != null) return database;

    database = await initDB();
    return database;
  }

  Future<Database> initDB() async {
    var path = join(await getDatabasesPath(), dbName);

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $table(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnDate TEXT NOT NULL
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  //Create
  Future<int> createPlan(Plan plan) async {
    final db = await instance.getDatabase;
    if (db != null) {
      var res = await db.insert(table, plan.toMap());
      return res;
    } else {
      return Future.error('error');
    }
  }

  //Read All
  Future<List<Map<String, dynamic>>> getAllPlans() async {
    final db = await instance.getDatabase;
    if (db != null) {
      return await db.query(table, orderBy: '$columnId DESC');
    } else {
      return Future.error('error');
    }
  }

  //Delete
  Future<int> deletePlan(int id) async {
    final db = await instance.getDatabase;
    if (db != null) {
      var res = db.delete(
        table,
        where: '$columnId = ?',
        whereArgs: [id],
      );
      return res;
    } else {
      return Future.error('error');
    }
  }

  //Delete All
  Future<void> clearPlans() async {
    final db = await instance.getDatabase;
    if (db != null) {
      await db.rawDelete('DELETE FROM $table');
    } else {
      return Future.error('error');
    }
  }

  Future<int> updatePlan(Plan plan) async {
    final db = await instance.getDatabase;
    if (db != null) {
      var res = await db.update(
        table,
        plan.toMap(),
        where: '$columnId = ?',
        whereArgs: [plan.id],
      );
      return res;
    } else {
      return Future.error('error');
    }
  }
}
