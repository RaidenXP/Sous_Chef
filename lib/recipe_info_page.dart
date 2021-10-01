import 'package:flutter/material.dart';

class RecipeInfo extends StatefulWidget {
  const RecipeInfo({Key? key}) : super(key: key);

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
            title: Text("Food Name Here"),
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Steps")),
                Tab(child: Text("Ingredients")),
                Tab(child: Text("Media"))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Text("Steps")),
              Center(child: Text("Ingredients")),
              Center(child: Text("Media"))
            ],
          ),
        ),
    );
  }
}
