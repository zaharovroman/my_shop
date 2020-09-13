import 'dart:convert';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'ProductDetailPage.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: FutureBuilder(
                future:
                    DefaultAssetBundle.of(context).loadString('data/data.json'),
                builder: (BuildContext context, snapshot) {
                  assert(context != null);
                  var myData = json.decode(snapshot.data.toString());
                  return new ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return new Container(
                          padding: const EdgeInsets.all(10),
                          child: RaisedButton(
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/${myData[index]['id']}.jpg',
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
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
                                                      myData[index]['name'],
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                Text(
                                                  myData[index]['price'],
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
                                          myData[index]['id'],
                                          myData[index]['name'],
                                          myData[index]['price'],
                                          myData[index]['description'])))
                            },
                          ));
                    },
                    itemCount: myData == null ? 0 : myData.length,
                  );
                })));
  }
}
