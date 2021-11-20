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
    FirebaseDatabase.instance.reference().child("recipes").onChildChanged.listen((event) {
      refresh();
    });
    FirebaseDatabase.instance.reference().child("recipes").onChildAdded.listen((event) {
      refresh();
    });
  }

  void refresh(){
    FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").once().then((datasnapshot){
      description = datasnapshot.value['ingredients'];

      setState(() {

      });
    }).catchError((error){
      print("Something went wrong in the recipeInfoPageIngred");
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
    return ListView(
      children: [
        Card(
        clipBehavior: Clip.antiAlias,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xB329124A), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
          ),
          child: Text(
            description,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18
             ),
            ),
          ),
        ),
      ]
    );
  }
}