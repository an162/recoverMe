import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "habitTracker.db";
  static final _databaseVersion = 4;  // Incremented version to handle schema change
  static final tableHabits = 'habits';
  static final columnId = 'id';
  static final columnName = 'habit_name';
  static final columnTarget = 'target_value';
  static final columnCurrent = 'current_value';
  static final columnSoberDays = 'sober_days';

  // New user table columns
  static final userTable = 'user';
  static final columnUserId = 'id';
  static final columnUserName = 'name';
  static final columnUserSurname = 'surname';
  static final columnUserEmail = 'email';
  static final columnUserPassword = 'password';
  static final columnUserBirthdate = 'birthdate';
  static final columnUserGender = 'gender';
  static final columnUserAddiction = 'addiction';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    Database db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,  // Handling the upgrade to ensure the new user table is created
    );
    return db;
  }

  Future _onCreate(Database db, int version) async {
    // Create habits table
    await db.execute('''
      CREATE TABLE $tableHabits (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnTarget INTEGER NOT NULL,
        $columnCurrent INTEGER NOT NULL
      )
    ''');

    // Create sober days table
    await db.execute('''
      CREATE TABLE sober_days_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnSoberDays INTEGER DEFAULT 0
      )
    ''');

    // Create achievements table
    await db.execute('''
      CREATE TABLE achievements_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        habit_name TEXT NOT NULL,
        date_achieved TEXT NOT NULL
      )
    ''');

    // Create user table (from teammate's implementation)
    await db.execute('''
      CREATE TABLE $userTable (
        $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUserName TEXT,
        $columnUserSurname TEXT,
        $columnUserEmail TEXT UNIQUE,
        $columnUserPassword TEXT,
        $columnUserBirthdate TEXT,
        $columnUserGender TEXT,
        $columnUserAddiction TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 4) {
      // Handle migrations for version 4
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $userTable (
          $columnUserId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnUserName TEXT,
          $columnUserSurname TEXT,
          $columnUserEmail TEXT UNIQUE,
          $columnUserPassword TEXT,
          $columnUserBirthdate TEXT,
          $columnUserGender TEXT,
          $columnUserAddiction TEXT
        )
      ''');
    }
  }

  // Insert user data
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert(userTable, user);
  }

  // Get user data by email
  Future<List<Map<String, dynamic>>> getUser(String email) async {
    Database db = await database;
    return await db.query(userTable, where: '$columnUserEmail = ?', whereArgs: [email]);
  }

  // Habit tracking methods
  Future<int> insertHabit(Map<String, dynamic> habit) async {
    Database db = await database;
    return await db.insert(tableHabits, habit);
  }

  Future<List<Map<String, dynamic>>> getHabits() async {
    Database db = await database;
    return await db.query(tableHabits);
  }

  Future<int> updateHabit(int id, int currentValue) async {
    Database db = await database;
    return await db.update(
      tableHabits,
      {columnCurrent: currentValue},
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteHabit(int id) async {
    Database db = await database;
    return await db.delete(
      tableHabits,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Sober days methods
  Future<int> getSoberDays() async {
    Database db = await database;
    final result = await db.query(
      'sober_days_table',
      columns: [columnSoberDays],
      where: 'id = ?',
      whereArgs: [1],
    );
    if (result.isNotEmpty) {
      return result.first[columnSoberDays] as int;
    } else {
      print('No row found in sober_days_table, creating one...');
      await db.insert('sober_days_table', {columnSoberDays: 0});
      return 0;
    }
  }

  Future<void> updateSoberDays(int newSoberDays) async {
    Database db = await database;
    final rowsUpdated = await db.update(
      'sober_days_table',
      {columnSoberDays: newSoberDays},
      where: 'id = ?',
      whereArgs: [1],
    );
    if (rowsUpdated == 0) {
      print('No rows updated! Check if the ID exists.');
    } else {
      print('Database updated with sober days: $newSoberDays');
    }
  }

  // Achievements methods
  Future<int> insertAchievement(String habitName) async {
    Database db = await database;
    return await db.insert('achievements_table', {
      'habit_name': habitName,
      'date_achieved': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getAchievements() async {
    Database db = await database;
    return await db.query('achievements_table');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
