import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app_project/addIngredient.dart';

class IngredientTab extends StatefulWidget {
  var recipeDetails;

  IngredientTab(this.recipeDetails);

  @override
  _IngredientTabState createState() => _IngredientTabState(recipeDetails);
}

class _IngredientTabState extends State<IngredientTab> {
  var recipeDetails;
  var description;

  _IngredientTabState(this.recipeDetails){
    FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").once().then((datasnapshot){
      description = datasnapshot.value['ingredients'];

      setState(() {

      });
    }).catchError((error){
      print("Something went wrong in the recipeInfoPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder:(context) => AddIngredientPage(recipeDetails))
          );
        },
        child: Icon(Icons.add),
      ),
      body: (description != null) ? Text(description.toString()) : Center(),
    );
  }
}
