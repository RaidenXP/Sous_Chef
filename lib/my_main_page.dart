import 'package:flutter/material.dart';

class MyMainPage extends StatefulWidget {
  MyMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add Recipe",
            onPressed: (){
              // I need to figure out how to add more list tiles from here
            },
          ),
        ],
      ),
      drawer: Drawer(
        //Gotta add some things later here
        //Still have to decide what settings or features are gonna be here
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Recipe 1'),
          ),
          ListTile(
            title: Text('Recipe 2'),
          ),
          ListTile(
            title: Text('Recipe 3'),
          ),
        ]
      ),
    );
  }
}