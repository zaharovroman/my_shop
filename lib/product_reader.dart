import 'dart:convert';

import 'package:flutter/services.dart';

import 'product.dart';

class ProductReader {
  String pathString;
  ProductReader(this.pathString);

  Future<String> _loadProductData() async {
    return await rootBundle.loadString(pathString);
  }

  Future loadProduct() async {
    String jsonString = await _loadProductData();
    return _parseJsonForProduct(jsonString);
  }

  List<Product> _parseJsonForProduct(String jsonString) {
    List decoded = json.decode(jsonString);
    List<Product> products = [];
    for (var item in decoded) {
      products.add(new Product.fromJson(item));
    }
    return products;
  }
}
