import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePage createState() => _AddRecipePage();
}

class _AddRecipePage extends State<AddRecipePage> {

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            ElevatedButton(
             child: Text("Add Recipe"),
             onPressed:(){
               var timestamp = new DateTime.now().millisecondsSinceEpoch;

               FirebaseDatabase.instance.reference().child("recipes/recipe" + timestamp.toString()).set(
                 {
                    "name" : nameController.text,
                 }
               ).then((value){
                 print("Sucessfully added!");
               }).catchError((error){
                 print("Failed to add. " + error.toString());
               });

               Navigator.pop(
                   context
               );
             }
            ),
          ],
        ),
      ),
    );
  }
}
