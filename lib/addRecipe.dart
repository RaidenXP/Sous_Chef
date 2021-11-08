import 'dart:io';
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
                        : Image.network('https://i.imgur.com/sUFH1Aq.png'),
                        onTap: (){
                          pickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Upload Image from Gallery",
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
                onPressed: () async{
                  var timestamp = new DateTime.now().millisecondsSinceEpoch;
                  var url;

                  if(_imageFile.path != ''){
                    await FirebaseStorage.instance.ref().child("food_images/" + timestamp.toString()).putFile(_imageFile);

                    var downloadUrl = await FirebaseStorage.instance.ref().child("food_images/" + timestamp.toString()).getDownloadURL()
                        .then((value) {
                          print("Url: " + value.toString());
                          url = value.toString();
                        }).catchError((error) {
                          print("Failed");
                        });

                    FirebaseDatabase.instance.reference().child("recipes/recipe" + timestamp.toString()).set(
                        {
                          "id": timestamp,
                          "name" : nameController.text,
                          "imagePath" : url,
                        }
                    ).then((value){
                      print("Succesfully added!");
                    }).catchError((error){
                      print("Failed to add. " + error.toString());
                    });

                  }else{
                    FirebaseDatabase.instance.reference().child("recipes/recipe" + timestamp.toString()).set(
                        {
                          "id": timestamp,
                          "name" : nameController.text,
                          "imagePath" : "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081",
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
