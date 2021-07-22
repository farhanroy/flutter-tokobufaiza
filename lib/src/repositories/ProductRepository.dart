import '../helper/DatabaseHelper.dart';
import '../models/Product.dart';
import '../utils/Constants.dart';

class CreateProductFailure implements Exception {}

class GetProductsFailure implements Exception {}

class GetDetailProductFailure implements Exception {}

class DeleteProductFailure implements Exception {}

class SearchProductFailure implements Exception {}

class ProductRepository {
  ProductRepository({DatabaseHelper? databaseHelper})
      : _databaseHelper = databaseHelper ?? DatabaseHelper();

  final DatabaseHelper _databaseHelper;

  Future<void> createProduct(Product product) async {
    try {
      var client = await _databaseHelper.db;
      await client!.insert(Constants.PRODUCT_TABLE, product.toMap());
    } catch (e) {
      throw CreateProductFailure();
    }
  }

  Future<List<Product>?> getProducts() async {
    try {
      var client = await _databaseHelper.db;
      List<Map> list =
          await client!.rawQuery('SELECT * FROM ${Constants.PRODUCT_TABLE}');
      List<Product> products = List.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        var product = new Product(
          id: list[i]["id"],
          title: list[i]["title"],
          price: list[i]["price"],
          imagePath: list[i]["imagePath"],
        );
        products.add(product);
      }
      return products;
    } catch (e) {
      throw GetProductsFailure();
    }
  }

  Future<Product?> getDetailProduct(int id) async {
    try {
      var client = await _databaseHelper.db;
      List<Map> list = await client!
          .rawQuery('SELECT * FROM ${Constants.PRODUCT_TABLE} where id = $id');
      Product product = Product.map(list.first);
      return product;
    } catch (e) {
      throw GetDetailProductFailure();
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      var client = await _databaseHelper.db;
      await client!.delete(
        Constants.PRODUCT_TABLE,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DeleteProductFailure();
    }
  }

  Future<List<Product>?> searchProduct(String query) async {
    try {
      var client = await _databaseHelper.db;
      List<Map> list = await client!.rawQuery(
          "SELECT * FROM ${Constants.PRODUCT_TABLE} WHERE title LIKE '%$query%' ");
      List<Product> products = List.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        var product = new Product(
          id: list[i]["id"],
          title: list[i]["title"],
          price: list[i]["price"],
          imagePath: list[i]["imagePath"],
        );
        products.add(product);
      }
      return products;
    } catch (e) {
      throw SearchProductFailure();
    }
  }

  Future<List<Product>?> updateProduct(Product product) async {
    try {
      var client = await _databaseHelper.db;
      await client!.update(
          Constants.PRODUCT_TABLE,
          product.toMap(),
          where: 'id = ?',
          whereArgs: [product.id]
      );
    } catch (e) {
      throw CreateProductFailure();
    }
  }
}
