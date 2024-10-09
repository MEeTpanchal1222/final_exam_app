import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteService {
  static final SQLiteService _instance = SQLiteService._();
  static Database? _database;

  SQLiteService._();

  factory SQLiteService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'local_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT
      )
    ''');
  }

  Future<int> adduser(Map<String, dynamic> users) async {
    final db = await database;
    return await db.insert('users', users);
  }

  Future<List<Map<String, dynamic>>> getuser() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> updateuser(int id, Map<String, dynamic> users) async {
    final db = await database;
    return await db.update('users', users, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteuser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> compareuser({required String name,email}) async {
    final db = await database;
    return await
    //db.query('users', columns: ['name','email'], where: '"name" = ?, "email" = ?', whereArgs:[name,email]);
    db.query('SELECT name, email FROM users WHERE "name" = ? AND "email" = ?', whereArgs:[name,email]);
  }
}