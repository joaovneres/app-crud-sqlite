import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/db.dart';
import 'package:appcrudsqlite/listProduct.dart';

class AddProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddProducts();
  }
}

class _AddProducts extends State<AddProducts> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController stockNumber = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController category = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar produto"),
        backgroundColor: Color.fromARGB(255, 0, 204, 190),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "Nome do produto:",
              ),
            ),
            Row(
              // Use a Row widget to display stockNumber and price side by side.
              children: [
                Expanded(
                  child: TextField(
                    controller: rollno,
                    decoration: InputDecoration(
                      hintText: "Roll No.",
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between the fields
                Expanded(
                  child: TextField(
                    controller: brand,
                    decoration: InputDecoration(
                      hintText: "Marca:",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              // Use a Row widget to display stockNumber and price side by side.
              children: [
                Expanded(
                  child: TextField(
                    controller: stockNumber,
                    decoration: InputDecoration(
                      hintText: "Estoque:",
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between the fields
                Expanded(
                  child: TextField(
                    controller: price,
                    decoration: InputDecoration(
                      hintText: "Preço:",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              // Use a Row widget to display stockNumber and price side by side.
              children: [
                Expanded(
                  child: TextField(
                    controller: gender,
                    decoration: InputDecoration(
                      hintText: "Genêro:",
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add some spacing between the fields
                Expanded(
                  child: TextField(
                    controller: category,
                    decoration: InputDecoration(
                      hintText: "Categoria:",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 9, 166, 163),
                ),
              ),
              onPressed: () {
                mydb.db.rawInsert(
                  "INSERT INTO product (name, roll_no, brand, stock_number, price, gender, category) VALUES (?, ?, ?, ?, ?, ?, ?);",
                  [
                    name.text,
                    rollno.text,
                    brand.text,
                    stockNumber.text,
                    price.text,
                    gender.text,
                    category.text,
                  ],
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Novo produto adicionado")),
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ListProduct();
                }));

                name.text = "";
                rollno.text = "";
                brand.text = "";
                stockNumber.text = "";
                price.text = "";
                gender.text = "";
                category.text = "";
              },
              child: Text("Salvar Produto"),
            ),
          ],
        ),
      ),
    );
  }
}
