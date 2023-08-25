import 'package:appcrudsqlite/listProduct.dart';
import 'package:flutter/material.dart';
import 'package:appcrudsqlite/addProduct.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Venda da Vivia"),
        backgroundColor: Color.fromARGB(255, 0, 204, 190),
      ),
      body: Container(
        color: Color.fromARGB(255, 252, 249, 216),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(children: [
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 9, 166, 163))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return AddProducts();
              }));
            },
            child: Text("Adicionar"),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 9, 166, 163))),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ListProduct();
              }));
            },
            child: Text("Listar"),
          ),
        ]),
      ),
    );
  }
}
