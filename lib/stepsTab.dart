import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app_project/addStep.dart';

class StepsTab extends StatefulWidget {
  var recipeDetails;

  StepsTab(this.recipeDetails);

  @override
  _StepsTabState createState() => _StepsTabState(recipeDetails);
}

class _StepsTabState extends State<StepsTab> {
  var recipeDetails;
  var description;

  _StepsTabState(this.recipeDetails){
    FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").once().then((datasnapshot){
      description = datasnapshot.value['steps'];

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
              MaterialPageRoute(builder:(context) => AddStepPage(recipeDetails))
          );
        },
        child: Icon(Icons.add),
      ),
      body: (description != null) ? Text(description.toString()) : Center(),
    );
  }
}
