import 'package:flutter/material.dart';
import 'package:my_app_project/ingredientTab.dart';
import 'package:my_app_project/mediaTab.dart';
import 'package:my_app_project/stepsTab.dart';

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
              IngredientTab(widget.recipeDetails),
              StepsTab(widget.recipeDetails),
              MediaTab(widget.recipeDetails)
            ],
          ),
        ),
    );
  }
}