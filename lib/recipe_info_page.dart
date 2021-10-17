import 'package:flutter/material.dart';

class RecipeInfo extends StatefulWidget {

  var recipeDetails;

  RecipeInfo(this.recipeDetails);

  @override
  _RecipeInfoState createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.recipeDetails.name}"),
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Ingredients")),
                Tab(child: Text("Steps")),
                Tab(child: Text("Media"))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text("Ingredients")),
              Center(child: Text("Steps")),
              Center(child: Text("Media"))
            ],
          ),
        ),
    );
  }
}
