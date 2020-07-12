import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/todo_class.dart';

class TodoDatabase {
  // make this a singleton class
  TodoDatabase._privateConstructor();
  static final TodoDatabase instance = TodoDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), 'todo_database.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
          CREATE TABLE todo(
            id INTEGER PRIMARY KEY, 
            details TEXT)
        ''');
    print("Database was created!");
  }

  //get all elements from the database
  Future<List<ToDo>> getAllToDo() async {
    var client = await db;
    final List<Map<String, dynamic>> maps = await client.query('todo');

    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        var todo = ToDo(null, maps[i]['id'], null, null);
        todo.details = maps[i]['details'];
        return todo;
      });
    } else
      return [];
  }

  Future<ToDo> getToDo(int id) async {
    var temp = await getAllToDo();
    return temp.firstWhere((element) => element.id == id);
  }

  Future<bool> checkIfTodoExistsInDB(int id) async {
    var temp = await getAllToDo();
    return temp.any((element) => element.id == id);
  }

  Future<void> insertToDo(ToDo todo) async {
    var client = await db;
    var output = await client.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(output);
  }

  Future<void> updateToDo(ToDo todo) async {
    var client = await db;
    await client.update(
      'todo',
      todo.toMap(),
      where: "id = ?",
      // use whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

//  Future<void> deleteToDo(int id) async {
//    var client = await db;
//    await client.delete(
//      'todo',
//      where: "id = ?",
//      whereArgs: [id],
//    );
//  }
}
