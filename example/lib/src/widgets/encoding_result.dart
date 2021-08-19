import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:huffman/huffman.dart';
import 'package:huffman_example/src/widgets/huffman_tree.dart';

class EncodingResult extends StatelessWidget {
  final HuffmanCode huffmanCode;
  final Map<Node, int> frequencyTable;
  final MapEntry<Node, int> tree;

  const EncodingResult(
      {Key? key,
      required this.huffmanCode,
      required this.frequencyTable,
      required this.tree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Encoded Value : ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Decoded Value'),
                          content: Text(
                            HuffmanCoding().decode(huffmanCode),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  text: '${huffmanCode.value}',
                  style: TextStyle(color: Colors.blue[800]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Huffman Code Table',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Table(
            border: TableBorder.all(color: Colors.black45),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Character',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Frequency',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Huffman Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              for (var i = 0; i < huffmanCode.huffmanTable.length; i++)
                TableRow(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${frequencyTable.entries.elementAt(i).key.key}',
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${frequencyTable.entries.elementAt(i).value}',
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${huffmanCode.huffmanTable.entries.where((element) => element.key == frequencyTable.entries.elementAt(i).key.key).first.value}',
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Huffman Tree',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          HuffmanTree(
            tree: tree,
            frequencyTable: frequencyTable,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
