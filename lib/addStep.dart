import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddStepPage extends StatefulWidget {
  var recipeDetails;

  AddStepPage(this.recipeDetails);

  @override
  _AddStepPageState createState() => _AddStepPageState();
}

class _AddStepPageState extends State<AddStepPage> {
  var steps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Steps"),
          actions: [
            IconButton(
              onPressed: (){
                FirebaseDatabase.instance.reference().child("recipes/recipe" + "${widget.recipeDetails.id}").update({
                  "steps": steps.text,
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
                        hintText: "Type Up the Steps",
                      ),
                      maxLines: null,
                      controller: steps,
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
