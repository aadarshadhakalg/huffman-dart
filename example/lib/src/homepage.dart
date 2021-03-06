import 'package:flutter/material.dart';
import 'package:huffman/huffman.dart';
import 'package:huffman_example/src/widgets/encoding_result.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputController = TextEditingController();
  final HuffmanCoding huffmanCoding = HuffmanCoding();

  HuffmanCode? encodedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HUFFMAN VISUALIZER'),
        actions: [
          TextButton(
            onPressed: () async {
              await launch(
                'https://github.com/aadarshadhakalg/huffman-dart',
                enableJavaScript: true,
              );
            },
            child: Text(
              'Github',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              await launch(
                'https://aadarshadhakalg.github.io/huffman-dart/',
                enableJavaScript: true,
              );
            },
            child: Text(
              'Docs',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _inputController,
                decoration: InputDecoration(
                  hintText: 'Text To Encode',
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  encodedValue = huffmanCoding.encode(_inputController.text);
                  print('object');
                  setState(() {});
                },
                child: Text('Encode'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(),
              Text(
                'Result',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              encodedValue != null
                  ? EncodingResult(
                      frequencyTable: huffmanCoding.frequencyTable,
                      tree: huffmanCoding.tree,
                      huffmanCode: encodedValue!,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
