import 'package:flutter/material.dart';
import 'my_main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sous Chef',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyMainPage(title: 'Sous Chef'),
    );
  }
}
