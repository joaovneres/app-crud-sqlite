import 'package:appcrudsqlite/listProduct.dart';
import 'package:appcrudsqlite/pages/home.dart';
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
  int _indiceAtual = 0;
  final List<Widget> _telas = [
    HomeScreen(),
    AddProducts(),
    ListProduct(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        selectedItemColor: Color.fromARGB(255, 0, 204, 190),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: "Loja"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: "Adicionar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Meus produtos"),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
