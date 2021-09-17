import 'package:flutter/material.dart';

class MyMainPage extends StatefulWidget {
  MyMainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {

  final List<String> entries = <String>['Recipe 1', 'Recipe2', 'Recipe 3'];

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
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
              title: Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(10.0),
                  color: Colors.tealAccent,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap:(){
                      print('Tapped');
                    },
                    child: Row(
                      children: [
                        Container(
                          child: Image(
                            color: Colors.teal,
                            colorBlendMode: BlendMode.color,
                            height: 100,
                            width: 100,
                            image: NetworkImage('https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20.0),
                          child: Text(
                            '${entries[index]}'
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