import '../sources/local/dao/ProductDao.dart';
import '../sources/local/entity/ProductEntity.dart';

class ProductRepository {
  late ProductDao _dao;

  ProductRepository() {
    _dao = ProductDao();
  }

  Future<List<ProductEntity>> getProducts() async {
    var products = await _dao.getProducts();
    return products;
  }
}