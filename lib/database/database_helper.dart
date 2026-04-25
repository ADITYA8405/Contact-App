import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database; // this line means Only ONE database instance exists

  Future<Database> get database async { // initial step - this make sure to check does databse exist for the first time
    if (_database != null) return _database!;
    _database = await initDB(); //
    return _database!;  
  }
  Future<Database> initDB() async {
  String path = join(await getDatabasesPath(), 'contacts.db');
 // now in the firs time the database is created and it creates several entry
  return await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async { // this oncreate is the name of our function to create databse.
      await db.execute('''
        CREATE TABLE contacts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          contact TEXT
        )
      '''); // now once the databse is made and it already exist there is no need to call Oncreate db  and it directly uses it existing db so basoca;;y oncreate runs only once in lifitme of an app
    },
  );
}
//crud operations 

//insert
Future<void> insertContact(String name, String contact) async {
  final db = await database;

  await db.insert(
    'contacts',  
    {
      'name': name,   // id is auto genrated we don't have to maunally enter
      'contact': contact,
    },
  );
}
//read 
//as apps starts initi state calls loadcontacts()and let the ui display the save data through loadcontact()
// yaha data map format m jaata h but ui m object 
// map format-{id: 1, name: "Aditya", contact: "123"} and object format is -Contact(name: "Aditya", contact: "123") reason- object zyada smooth and clean feel hota h and future 
// future m naye feaures add kerte smaay easily modifed kiya ja sakta h

Future<List<Map<String, dynamic>>> getContacts() async {
  final db = await database;
  return await db.query('contacts');
}

//update contacts 
//as soon as the user clicks on edit button, selected index is called but remeber update is called on the basis of id not indexas index can change but id is unique

Future<void> updateContact(int id, String name, String contact) async {
  final db = await database;

  await db.update(
    'contacts',
    {
      'name': name,
      'contact': contact,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
}
//delte 
Future<void> deleteContact(int id) async {
  final db = await database;

  await db.delete(
    'contacts',
    where: 'id = ?',
    whereArgs: [id],
  );
}












}