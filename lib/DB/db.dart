import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  late Database db;

  Future<Database> get database async{
    if(db != null) return db;

    db = await initDB();
    return db;
  }

  initDB() async{
    String path = join(await getDatabasesPath(), 'Plan.db');

    return openDatabase(
      path,
      version: 1,
      onCreate:(db, version) async{
        await db.execute('CREATE TABLE Plan(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT)');
      }, onUpgrade: (db, oldVersion, newVersion){}
    ); 
  }
  
}