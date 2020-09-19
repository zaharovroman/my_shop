import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'favorite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'my_shop.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Favorite(id INTEGER PRIMARY KEY)");
    });
  }

  newFavorite(Favorite newFavorite) async {
    final db = await database;
    var res = await db.insert("Favorite", newFavorite.toMap());
    return res;
  }

  getFavorite(int id) async {
    final db = await database;
    var res = await db.query("Favorite", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Favorite.fromMap(res.first) : null;
  }

  getAllFavorites() async {
    final db = await database;
    var res = await db.query("Favorite");
    List<Favorite> list =
        res.isNotEmpty ? res.map((c) => Favorite.fromMap(c)).toList() : [];
    return list;
  }

  deleteFavorite(int id) async {
    final db = await database;
    db.delete("Favorite", where: "id = ?", whereArgs: [id]);
  }
}
