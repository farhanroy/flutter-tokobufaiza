import 'package:sqflite/sqflite.dart';

import '../AppDatabase.dart';
import '../entity/ProductEntity.dart';

class ProductDao {
  Database? _db;

  ProductDao() {
    _getDbInstance();
  }

  void _getDbInstance() async => _db = await AppDatabase.getInstance();

  Future<List<ProductEntity>> getProducts() async {
    List<ProductEntity> list = [];

    List<Map> maps = await _db!.query(
        ProductEntity.entityName,
        columns: [ProductEntity.columnId, ProductEntity.columnTitle]
    );

    if (maps.length > 0) list = ProductEntity.fromJsonList(maps);

    return list;
  }

}
