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
      body: (description != null) ? _DescriptionWidget(description.toString()) : Center(),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  var description;

  _DescriptionWidget(this.description);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Container(
        width: 500,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.redAccent, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            description,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
      ),
      elevation: 15,
      clipBehavior: Clip.antiAlias,
    );
  }
}