import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' ;

class SqlHelper {
  static Database? _db ;
  Future<Database?> get db async{
    if(_db == null){
      _db = await intialDb();   return _db ;
    }
   else return _db ;
  }

  intialDb() async{
String databasepath = await  getDatabasesPath();
String path = join(databasepath , 'amira.db');
Database mydb = await openDatabase(path ,version: 1,
  onUpgrade:(Database db , int oldversion , int newversion) async {
    print("upgraded       ****************************");
  } ,
  onCreate: (Database db, int version) async {
  await db.execute('''
          CREATE TABLE notes (
            "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            "title" TEXT,
            "description" TEXT,
            "isDone" INTEGER
          )
        ''');
  print("created ****************************");
},
);
return mydb ;
}
  readData(String sql) async{
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
}
  insertData(String sql) async{
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql) async{
    Database? mydb = await db ;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
  deleteData(String sql) async{
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  DeleteDatabase() async{
  String databasepath = await  getDatabasesPath();
  String path = join(databasepath , 'amira.db');
  await deleteDatabase(path) ;
  print("deleted");
}
}