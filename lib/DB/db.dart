import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/DB/model.dart';

class DBHelper{
  static final DBHelper instance = DBHelper.init();
  static Database? db;
  DBHelper.init();

  Future<Database> get database async{
    if(db != null) return db!;
    db = await initDB();
    return db!;
  }

  Future<Database> initDB() async{
    final path = join(await getDatabasesPath(), 'plans.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: createDB
    ); 
  }

  Future createDB(Database db, int version) async{
    await db.execute(
      '''CREATE $tableName (${PlanFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${PlanFields.title} TEXT NOT NULL, ${PlanFields.date} TEXT NOT NULL)''');
  }

  Future<Plan> create(Plan plan) async{
    final db = await instance.database;
    final id = await db.insert(tableName, plan.toJson());
    return plan.copy(id: id);
  }

  Future<int> update(Plan plan) async{
    final db = await instance.database;
    return db.update(
      tableName,
      plan.toJson(),
      where: '${PlanFields.id} = ?',
      whereArgs: [plan.id]
    );
  }


  Future close() async{
    final db = await instance.database;
    db.close();
  }


  
  
}

