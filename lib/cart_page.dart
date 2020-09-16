import 'package:flutter/material.dart';

import 'cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var data = Cart().currentCart;
    return Scaffold(
        appBar: AppBar(
            title: Column(children: [
          Text('Корзина'),
          Text('Итого: ${Cart().totalPrice} ₽')
        ])),
        body: new Center(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var product = data.keys.elementAt(index);
                  var count = data[product];
                  return new Container(
                      padding: EdgeInsets.all(10),
                      child: Row(children: [
                        Image.asset(
                          'assets/images/${product.id}.jpg',
                          width: MediaQuery.of(context).size.width / 2.3,
                        ),
                        Flexible(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      product.name.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text((product.price * count).toString() +
                                      " ₽"),
                                  Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                Cart().changeCountOfProduct(
                                                    product, Operation.minus);
                                                if (Cart()
                                                        .currentCart[product] ==
                                                    0) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Удалить товар из корзины?"),
                                                          actions: [
                                                            RaisedButton(
                                                              child: Text("Да"),
                                                              onPressed: () {
                                                                Cart().remove(
                                                                    product);
                                                                setState(() {});
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            RaisedButton(
                                                              child:
                                                                  Text("Нет"),
                                                              onPressed: () {
                                                                Cart().currentCart[
                                                                    product] = 1;
                                                                setState(() {});
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                }

                                                setState(() {});
                                              },
                                            ),
                                            Text(count.toString()),
                                            IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  Cart().changeCountOfProduct(
                                                      product, Operation.plus);
                                                  setState(() {});
                                                })
                                          ],
                                        ),
                                      )),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    Text("Удалить из корзины?"),
                                                actions: [
                                                  RaisedButton(
                                                    child: Text("Да"),
                                                    onPressed: () {
                                                      Cart().remove(product);
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  RaisedButton(
                                                    child: Text("Нет"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      })
                                ],
                              ),
                            ),
                          ),
                        )
                      ]));
                },
                itemCount: data == null ? 0 : data.length)));
  }
}
