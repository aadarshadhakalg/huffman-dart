import 'package:flutter/material.dart';
import 'package:huffman_example/src/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Huffman Visualizer',
      home: MyHomePage(),
    );
  }
}
