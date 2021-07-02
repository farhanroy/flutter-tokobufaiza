class Product {
  late int id;
  late String title;

  Product({required this.id, required this.title});

  Product.map(dynamic obj) {
    this.id = obj["id"];
    this.title = obj["title"];
  }

  Map<String, Object> toMap() {
    var map = new Map<String, Object>();

    map["id"] = id;
    map["title"] = title;

    return map;
  }
}
