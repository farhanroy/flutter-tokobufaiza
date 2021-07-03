class Product {
  late int id;
  late String title;
  late String price;
  late String imagePath;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.imagePath});

  Product.map(dynamic obj) {
    this.id = obj["id"];
    this.title = obj["title"];
    this.price = obj["price"];
    this.imagePath = obj["imagePath"];
  }

  Map<String, Object> toMap() {
    var map = new Map<String, Object>();
    map["id"] = id;
    map["title"] = title;
    map["price"] = price;
    map["imagePath"] = imagePath;
    return map;
  }
}
