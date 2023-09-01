import 'dart:math';

import 'package:appcrudsqlite/editProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/db.dart';

class ListProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListProduct();
  }
}

class _ListProduct extends State<ListProduct> {
  List<Map> productsList = [];
  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      // Use delay min 500 ms, because database takes time to initialize.

      productsList = await mydb.db.rawQuery('SELECT * FROM product');

      setState(() {}); // Refresh UI after getting data from the table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos Cadastrados"),
        backgroundColor: Color.fromARGB(255, 0, 204, 190),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 500,
          alignment: Alignment.center, // Centralize vertical e horizontalmente
          child: productsList.length == 0
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 0, 204, 190),
                    ),
                  ),
                )
              : Column(
                  children: productsList.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.shopping_cart),
                        title: Text(stuone["name"]),
                        subtitle: Text("Roll No:" +
                            stuone["roll_no"].toString() +
                            "\nMarca: " +
                            stuone["brand"] +
                            "\nNúmero em estoque: " +
                            stuone["stock_number"].toString() +
                            "\nPreço: " +
                            stuone["price"].toString() +
                            "\nGenêro: " +
                            stuone["gender"] +
                            "\nCategoria: " +
                            stuone["category"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return EditProduct(
                                          rollno: stuone["roll_no"]);
                                    },
                                  )).then((result) {
                                    if (result != null && result) {
                                      getdata(); // Atualize a lista após a edição
                                    }
                                  });
                                  //navigate to edit page, pass student roll no to edit
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                              onPressed: () {
                                _confirmDelete(
                                    stuone["roll_no"],
                                    stuone[
                                        "name"]); // Chame o método de confirmação
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }

  void _confirmDelete(int rollNo, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar Exclusão"),
          content: Text(
              "Tem certeza de que deseja excluir o produto " + name + " ?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal de confirmação
              },
            ),
            TextButton(
              child: Text("Confirmar"),
              onPressed: () async {
                await mydb.db.rawDelete(
                    "DELETE FROM product WHERE roll_no = ?", [rollNo]);
                Navigator.of(context).pop(); // Fecha o modal de confirmação
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Produto Apagado!"),
                ));
                getdata(); // Atualize a lista após a exclusão
              },
            ),
          ],
        );
      },
    );
  }
}
