import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/db.dart';

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

  //test editing controllers for form

  MyDb mydb = new MyDb(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
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
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              TextField(
                controller: brand,
                decoration: InputDecoration(
                  hintText: "Marca:",
                ),
              ),
              TextField(
                controller: stockNumber,
                decoration: InputDecoration(
                  hintText: "Quantidade em estoque:",
                ),
              ),
              TextField(
                controller: price,
                decoration: InputDecoration(
                  hintText: "Preço:",
                ),
              ),
              TextField(
                controller: gender,
                decoration: InputDecoration(
                  hintText: "Genêro:",
                ),
              ),
              TextField(
                controller: category,
                decoration: InputDecoration(
                  hintText: "Categoria:",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO students (name, roll_no, brand, stock_number, price, gender, category) VALUES (?, ?, ?, ?, ?, ?, ?);",
                        [
                          name.text,
                          rollno.text,
                          brand.text,
                          stockNumber.text,
                          price.text,
                          gender.text,
                          category.text
                        ]); //add product from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New Product Added")));

                    //show snackbar message after adding product
                    name.text = "";
                    rollno.text = "";
                    brand.text = "";
                    stockNumber.text = "";
                    price.text = "";
                    gender.text = "";
                    category.text = "";

                    //clear form to empty after adding data
                  },
                  child: Text("Save Product Data")),
            ],
          ),
        ));
  }
}
