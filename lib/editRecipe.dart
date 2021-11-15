import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EditRecipePage extends StatefulWidget {
  var recipeDetails;

  EditRecipePage(this.recipeDetails);

  @override
  _EditRecipePage createState() => _EditRecipePage(recipeDetails);
}

class _EditRecipePage extends State<EditRecipePage> {
  var recipeDetails;

  _EditRecipePage(this.recipeDetails);

  var nameController = TextEditingController();

  File _imageFile = new File('');
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
      print(_imageFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Recipe"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 100.0),
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            spreadRadius: 2,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: InkWell(
                        child: (_imageFile.path != '')
                            ? Image.file(_imageFile)
                            : Image.network(recipeDetails.image),
                        onTap: (){
                          pickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Upload Different Image from Gallery",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0, bottom: 30.0),
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
                      labelText: recipeDetails.name,
                    ),
                ),
              ),
              ElevatedButton(
                child: Text("Confirm Recipe"),
                onPressed: () async{
                  var url;
                  var result = await FirebaseStorage.instance.ref().child("food_images/recipe" + "${recipeDetails.id}/").listAll();
                  var num = 0;
                  result.items.forEach((element) {
                    ++num;
                  });

                  if(_imageFile.path != ''){
                    await FirebaseStorage.instance.ref()
                        .child("food_images/recipe" + "${recipeDetails.id}/image" + num.toString())
                        .putFile(_imageFile);

                    var downloadUrl = await FirebaseStorage.instance.ref()
                        .child("food_images/recipe" + "${recipeDetails.id}/image" + num.toString()).getDownloadURL()
                        .then((value) {
                      print("Url: " + value.toString());
                      url = value.toString();
                    }).catchError((error) {
                      print("Failed");
                    });

                    FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").update(
                        {
                          "imagePath" : url,
                        }
                    ).then((value){
                      print("Succesfully added!");
                    }).catchError((error){
                      print("Failed to add. " + error.toString());
                    });

                    if(nameController.text != '') {
                      FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").update(
                          {
                            "name" : nameController.text,
                          }
                      ).then((value){
                        print("Succesfully added!");
                      }).catchError((error){
                        print("Failed to add. " + error.toString());
                      });
                    }

                  }else{
                    FirebaseDatabase.instance.reference().child("recipes/recipe" + "${recipeDetails.id}").update(
                        {
                          "name" : nameController.text,
                        }
                    ).then((value){
                      print("Succesfully added!");
                    }).catchError((error){
                      print("Failed to add. " + error.toString());
                    });

                  }

                  Navigator.pop(
                    context,
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