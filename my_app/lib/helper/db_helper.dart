// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:my_app/model/model_db_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.getInstance();

  DbHelper.getInstance();

  factory DbHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();

    return _db!;
  }

  Future<Database> _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorites.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS ImageData(id TEXT, imageUrl TEXT)");
  }

  Future<int> addImageData(ImageData imageData) async {
    var dbClient = await db;
    int res = await dbClient.insert("ImageData", imageData.toMap());
    return res;
  }

  Future<int> deleteImageData(String imageUrl) async {
    var dbClient = await db;
    int res = await dbClient
        .delete("ImageData", where: "imageUrl = ?", whereArgs: [imageUrl]);
    return res;
  }

  Future<List<ImageData>> getAllImageData() async {
    var dbClient = await db;
    List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM ImageData');
    List<ImageData> imageDataList = [];
    for (int i = 0; i < list.length; i++) {
      imageDataList.add(ImageData.fromMap(list[i]));
    }
    return imageDataList;
  }
}
