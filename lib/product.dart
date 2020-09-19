class Product {
  String name;
  int price;
  String description;
  int id;
  bool isFavorite;
  Product(this.id, this.name, this.price, this.description, this.isFavorite);

  Product.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.price = json['price'];
    this.description = json['description'];
    this.isFavorite = json['isFavorite'];
  }
}
