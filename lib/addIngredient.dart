import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddIngredientPage extends StatefulWidget {
  var recipeDetails;

  AddIngredientPage(this.recipeDetails);

  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  var ingredient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ingredients"),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseDatabase.instance.reference().child("recipes/recipe" + "${widget.recipeDetails.id}").update({
                "ingredients": ingredient.text,
              }).then((value){
                print("Added to DataBase");
              }).catchError((error){
                print("Failed to add. " + error.toString());
              });

              Navigator.pop(context);
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Up the Ingredients",
                    ),
                    maxLines: null,
                    controller: ingredient,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
