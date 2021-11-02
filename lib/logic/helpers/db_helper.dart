import 'dart:ffi';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final String dbpath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbpath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, task_name TEXT,is_done bool ,done_date TEXT');
      },
      version: 1,
    );
  }

  static Future<void> insert(String task, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(task, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String task) async {
    final db = await DBHelper.database();
    return await db.query(task);
  }

  static Future<void> update(String task, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.update(task, data, where: 'id = ?', whereArgs: [data['id']]);
  }
}
