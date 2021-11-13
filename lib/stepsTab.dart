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