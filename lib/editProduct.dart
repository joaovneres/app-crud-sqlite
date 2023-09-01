import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/db.dart';
import 'package:appcrudsqlite/listProduct.dart';

class EditProduct extends StatefulWidget {
  int rollno;

  EditProduct({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditProduct();
  }
}

class _EditProduct extends State<EditProduct> {
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

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getProduct(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        name.text = data["name"];
        rollno.text = data["roll_no"].toString();
        brand.text = data["brand"];
        stockNumber.text = data["stock_number"].toString();
        price.text = data["price"].toString();
        gender.text = data["gender"].toString();
        category.text = data["category"];

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Produtos"),
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 9, 166, 163)),
                ),
                onPressed: () async {
                  await mydb.db.rawInsert(
                    "UPDATE product SET name = ?, roll_no = ?, brand = ?, " +
                        "stock_number = ?, price = ?, gender = ?, category = ? " +
                        "WHERE roll_no = ?",
                    [
                      name.text,
                      rollno.text,
                      brand.text,
                      stockNumber.text,
                      price.text,
                      gender.text,
                      category.text,
                      widget.rollno
                    ],
                  );

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Produto Alterado!"),
                  ));

                  Navigator.pop(context,
                      true); // Retorna à tela de lista com um valor de retorno positivo
                },
                child: Text("Alterar Produto"),
              )
            ],
          ),
        ));
  }
}
