import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'dart:core';

abstract class CartBase {
  @protected
  Map<Product, int> cart;

  void removeAll() {
    cart.clear();
  }

  void remove(Product product) {
    cart.remove(product);
  }

  void append(Product product) {
    cart[product] == null ? cart[product] = 1 : cart[product]++;
  }

  void changeCountOfProduct(Product product, Operation operation) {
    switch (operation) {
      case Operation.plus:
        {
          cart[product]++;
          break;
        }
      case Operation.minus:
        {
          cart[product]--;
          break;
        }
      default:
        {
          break;
        }
    }
  }

  int get totalPrice => cart.isEmpty
      ? 0
      : cart.entries
          .map<int>((value) => value.key.price * value.value)
          .reduce((a, b) => a + b);

  int get length => cart.length;

  Map<Product, int> get currentCart => cart;
}

class Cart extends CartBase {
  static final Cart _instance = Cart._internal();
  factory Cart() {
    return _instance;
  }
  Cart._internal() {
    cart = {};
  }
}

enum Operation { plus, minus }
