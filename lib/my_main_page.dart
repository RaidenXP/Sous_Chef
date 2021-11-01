import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_app_project/addRecipe.dart';
import 'package:my_app_project/recipe.dart';
import 'package:my_app_project/recipe_info_page.dart';

class MyMainPage extends StatefulWidget {
  MyMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {

  var entries = [];
  var urlImage;

  _MyMainPageState(){
    //load into the entries list above
    refresh();
    FirebaseDatabase.instance.reference().child("recipes").onChildChanged.listen((event) {
      print("Data Changed");
      refresh();
    });
    FirebaseDatabase.instance.reference().child("recipes").onChildRemoved.listen((event) {
      print("Data Removed");
      refresh();
    });
    FirebaseDatabase.instance.reference().child("recipes").onChildAdded.listen((event) {
      print("Data Added");
      refresh();
    });
  }

  void refresh(){
    FirebaseDatabase.instance.reference().child("recipes").once()
        .then((datasnapshot) {
      if(datasnapshot.exists){
        print("Successfully loaded the data");
        var tempList = [];
        datasnapshot.value.forEach((k, v){
          Recipe tempItem = Recipe(name: v['name'], image: v['imagePath']);
          tempList.add(tempItem);
        });
        entries = tempList;
      }
      else {
        print("No data");
      }
      setState(() {

      });
    }).catchError((error) {
      print("Failed to load the data");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add Recipe",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => AddRecipePage())
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        //Gotta add some things later here
        //Still have to decide what settings or features are gonna be here
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
              title: Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 15,
                  margin: EdgeInsets.all(10.0),
                  color: Colors.tealAccent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => RecipeInfo(entries[index]))
                      );
                    },
                    child: Row(
                      children: [
                        Expanded(
                          flex: 30,
                          child: Container(
                            child: Image(
                              image: NetworkImage(entries[index].image),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                            margin: EdgeInsets.all(20.0),
                            child: Text(
                                entries[index].name
                           ),
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            child: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(child: Text("Edit")),
                                PopupMenuItem(child: Text("Delete"))
                              ],
                              icon: Icon(Icons.more_vert_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          );
        }
      ),
    );
  }
}