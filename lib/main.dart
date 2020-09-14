import 'package:flutter/material.dart';
import 'package:my_shop/product_reader.dart';
import 'product.dart';
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

  ProductReader reader = ProductReader('data/data.json');
  List<Product> data;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductReader reader = ProductReader('data/data.json');
  List<Product> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: reader.loadProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                data = snapshot.data;
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
                                                data[index].price,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                    builder: (context) => ProductDetailPage(
                                        data[index].id,
                                        data[index].name,
                                        data[index].price,
                                        data[index].description)))
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
