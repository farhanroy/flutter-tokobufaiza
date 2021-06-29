import '../sources/local/dao/ProductDao.dart';
import '../sources/local/entity/ProductEntity.dart';

class ProductNotFoundFailure implements Exception {}

class ProductRepository {
  ProductRepository({ProductDao? productDao}):
        _dao = productDao ?? ProductDao();

  final ProductDao _dao;

  Future<List<ProductEntity>> getProducts() async {
    final products = await _dao.getProducts();

    if (products == null) {
      throw ProductNotFoundFailure();
    }
    return products;
  }
}