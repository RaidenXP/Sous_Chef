import 'package:flutter/material.dart';

class RecipeInfo extends StatefulWidget {
  const RecipeInfo({Key? key}) : super(key: key);

  @override
  _RecipeInfoState createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: false,
            backgroundColor: Colors.purple,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Food Name',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              background: Image.network(
                'https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (content, index) => ListTile(title: Text('Steps')),
              childCount: 25,
            ),
          ),
        ],
      ),
    );
  }
}
