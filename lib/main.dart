import 'package:flutter/material.dart';
import 'package:my_shop/cart.dart';
import 'package:my_shop/cart_page.dart';
import 'package:my_shop/product_reader.dart';
import 'product_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Каталог'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductReader reader = ProductReader('data/data.json');
  final cart = Cart();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                })
          ],
        ),
        body: FutureBuilder(
            future: reader.loadProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data;
                return Center(
                    child: new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                        padding: const EdgeInsets.all(10),
                        child: RaisedButton(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/${data[index].id}.jpg',
                                width: MediaQuery.of(context).size.width / 2.3,
                              ),
                              Flexible(
                                  child: Center(
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    data[index].name,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              Text(
                                                data[index].price.toString() +
                                                    " ₽",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              RawMaterialButton(
                                                child: Icon(
                                                    Icons.add_shopping_cart),
                                                shape: CircleBorder(),
                                                onPressed: () {
                                                  Cart().append(data[index]);

                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        Future.delayed(
                                                            Duration(
                                                                milliseconds:
                                                                    500), () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        });
                                                        return AlertDialog(
                                                          content: Icon(
                                                            Icons.done,
                                                            size: 80,
                                                          ),
                                                          shape: CircleBorder(),
                                                        );
                                                      });
                                                },
                                              )
                                            ],
                                          ))))
                            ],
                          ),
                          color: Colors.white,
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailPage(data[index])))
                          },
                        ));
                  },
                  itemCount: data == null ? 0 : data.length,
                ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
