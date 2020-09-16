import 'package:flutter/material.dart';
import 'package:my_shop/cart.dart';
import 'package:my_shop/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Описание'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Image.asset(
                    'assets/images/${product.id}.jpg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        product.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              product.price.toString() + " ₽",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  Cart().append(product);

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(
                                            Duration(milliseconds: 500), () {
                                          Navigator.of(context).pop(true);
                                        });
                                        return AlertDialog(
                                          content: Icon(
                                            Icons.done,
                                            size: 80,
                                          ),
                                          shape: CircleBorder(),
                                        );
                                      });
                                })
                          ])),
                  Text(
                    product.description,
                  )
                ]))));
  }
}
