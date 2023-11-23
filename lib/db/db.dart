import 'package:expenser/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DB {
  Database? _database;

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id TEXT PRIMARY KEY,
        timestamp TEXT,
        category TEXT,
        modeOfPayment TEXT,
        description TEXT,
        amount REAL
      )
    ''');
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'expenser.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<List<Expense>> getExpenses() async {
    var db = await database;
    var maps = await db!.query('expenses');
    return List.generate(maps.length, (index) => Expense.fromMap(maps[index]));
  }

  Future<void> insertExpense(Expense expense) async {
    var db = await database;
    await db!.insert('expenses', expense.toMap());
  }

  Future<void> updateExpense(Expense expense) async {
    var db = await database;
    await db!.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(Expense expense) async {
    var db = await database;
    await db!.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<double> totalSpent() async {
    var db = await database;
    var result = await db!.rawQuery('SELECT SUM(amount) FROM expenses');
    var value = result[0]['SUM(amount)'].toString();
    if (value == "null") {
      return 0.0;
    }
    return double.parse(value);
  }
}
