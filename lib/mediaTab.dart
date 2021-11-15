import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaTab extends StatefulWidget {
  var recipeDetails;

  MediaTab(this.recipeDetails);

  @override
  _MediaTabState createState() => _MediaTabState(recipeDetails);
}

class _MediaTabState extends State<MediaTab> {
  var recipeDetails;
  var mediaEntries = [];

  _MediaTabState(this.recipeDetails){
    refresh();
  }

  void refresh() async{
    var result = await FirebaseStorage.instance.ref().child("food_images/recipe" + "${recipeDetails.id}").listAll();

    result.items.forEach((element) async{
      var downloadUrl = await element.getDownloadURL()
          .then((value) {
        mediaEntries.add(value.toString());
        setState(() {

        });
      }).catchError((error) {
        print("Failed");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
          ),
        itemCount: mediaEntries.length,
        itemBuilder: (BuildContext context, index){
          return Container(
            child: Image(
              image: NetworkImage(mediaEntries[index]),
            ),
          );
        },
      ),
    );
  }
}
