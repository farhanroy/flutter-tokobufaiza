import '../helper/DatabaseHelper.dart';
import '../models/Product.dart';
import '../utils/Constants.dart';

class CreateProductFailure implements Exception {}

class GetProductsFailure implements Exception {}

class ProductRepository {
  ProductRepository({DatabaseHelper? databaseHelper}):
        _databaseHelper = databaseHelper ?? DatabaseHelper();

  final DatabaseHelper _databaseHelper;

  Future<void> createProduct(Product product) async {
    try {
      var client = await _databaseHelper.db;
      await client!.insert(Constants.PRODUCT_TABLE, product.toMap());
    } catch(e) {
      throw CreateProductFailure();
    }
  }

  Future<List<Product>?> getProducts() async {
    try {
      var client = await _databaseHelper.db;
      List<Map> list = await client!.rawQuery('SELECT * FROM ${Constants.PRODUCT_TABLE}');
      List<Product> products = List.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        var product =
        new Product(id: list[i]["id"], title: list[i]["title"]);
        products.add(product);
      }
      return products;
    } catch(e) {
      throw GetProductsFailure();
    }
  }
}