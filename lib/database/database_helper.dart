import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      surname TEXT,
      email TEXT UNIQUE,
      password TEXT,
      birthdate TEXT,
      gender TEXT,
      addiction TEXT
    );
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await instance.database;
    return await db.insert('user', user);
  }

  Future<List<Map<String, dynamic>>> getUser(String email) async {
    final db = await instance.database;
    return await db.query('user', where: 'email = ?', whereArgs: [email]);
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
