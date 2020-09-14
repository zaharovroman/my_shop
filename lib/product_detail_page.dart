import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final int id;
  ProductDetailPage(this.id, this.name, this.price, this.description);
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
                    'assets/images/$id.jpg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        price,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                        textAlign: TextAlign.center,
                      )),
                  Text(
                    description,
                  )
                ]))));
  }
}
