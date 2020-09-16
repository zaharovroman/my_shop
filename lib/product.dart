class Product {
  String name;
  int price;
  String description;
  int id;

  Product(this.id, this.name, this.price, this.description);

  Product.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.price = json['price'];
    this.description = json['description'];
  }
}
