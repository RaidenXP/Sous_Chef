import 'package:flutter/material.dart';
import 'my_main_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sous Chef',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print("ERROR! ${snapshot.error.toString()}");
            return Text("Something went wrong!");
          }else if(snapshot.hasData){
            return MyMainPage(title: 'Sous Chef');
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ) ,
    );
  }
}
