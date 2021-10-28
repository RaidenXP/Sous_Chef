import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: InkWell(
                  child: Image(
                    image: NetworkImage("https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081"),
                  ),
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: (){
                    //will implement
                    print("hi");
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                    labelText: 'Food Name Here',
                  ),
                  validator: (String? value){
                    if(value != null && value.isEmpty){
                      return 'Name is required';
                    }
                    return null;
                  }
                ),
              ),
              ElevatedButton(
                child: Text("Add Recipe"),
                onPressed: (){
                  var timestamp = new DateTime.now().millisecondsSinceEpoch;

                  FirebaseDatabase.instance.reference().child("recipes/recipe" + timestamp.toString()).set(
                    {
                      "name" : nameController.text,
                    }
                  ).then((value){
                    print("Succesfully added!");
                  }).catchError((error){
                    print("Failed to add. " + error.toString());
                  });

                  Navigator.pop(
                    context
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
