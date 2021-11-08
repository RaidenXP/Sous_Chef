import 'package:flutter/material.dart';
import 'package:my_app_project/ingredientTab.dart';
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
              Center(child: IngredientTab(widget.recipeDetails)),
              Center(child: StepsTab(widget.recipeDetails)),
              Center(child: _MediaTab())
            ],
          ),
        ),
    );
  }
}

class _MediaTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
    );
  }
}