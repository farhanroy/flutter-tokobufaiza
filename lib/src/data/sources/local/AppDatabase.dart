import 'package:sqflite/sqflite.dart';

import 'entity/ProductEntity.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database?> getInstance() async {
    if (_db == null) {
      _db = await openDatabase('my_db.db', version: 1, onCreate: (Database db, int version) async {

        await db.execute(
            ProductEntity.create()
        );

      });
    }

    return _db;
  }

  static close() async {
    await _db!.close();
  }
}