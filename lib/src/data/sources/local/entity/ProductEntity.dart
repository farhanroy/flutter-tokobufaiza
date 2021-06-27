class ProductEntity {
  static final String entityName = 'product';
  static final String columnId = '_id';
  static final String columnTitle = 'title';

  late int id;
  late String title;

  Map toJson() => {columnId: id, columnTitle: title};

  static List<ProductEntity> fromJsonList(List<dynamic> json) =>
      json.map((i) => ProductEntity.fromJson(i)).toList();

  ProductEntity.fromJson(Map<String, dynamic> json) {
    id = json[columnId];
    title = json[columnTitle];
  }

  static String create() {
    return "CREATE TABLE $entityName (" +
        "$entityName INTEGER PRIMARY KEY " +
        "$columnTitle TEXT" +
        ")";
  }
}
