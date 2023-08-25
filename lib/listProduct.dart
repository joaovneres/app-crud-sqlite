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
      //use delay min 500 ms, because database takes time to initilize.

      productsList = await mydb.db.rawQuery('SELECT * FROM product');

      setState(() {}); //refresh UI after getting data from table.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Produtos Cadastrados"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: productsList.length == 0
              ? Text("Carregando Produtos")
              : //show message if there is no any student

              Column(
                  //or populate list to Column children if there is student data.

                  children: productsList.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text(stuone["name"]),
                        subtitle: Text("Roll No:" +
                            stuone["roll_no"].toString() +
                            ", Marca: " +
                            stuone["brand"] +
                            ", Número em estoque: " +
                            stuone["stock_number"].toString() +
                            ", Preço: " +
                            stuone["price"].toString() +
                            ", Genêro: " +
                            stuone["gender"] +
                            ", Categoria: " +
                            stuone["category"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditProduct(
                                        rollno: stuone["roll_no"]);
                                  })); //navigate to edit page, pass student roll no to edit
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM product WHERE roll_no = ?",
                                      [stuone["roll_no"]]);

                                  //delete student data with roll no.

                                  print("Data Deleted");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Produto Apagado!")));

                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
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
}
