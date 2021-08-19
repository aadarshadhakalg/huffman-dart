import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:huffman/huffman.dart';

class HuffmanTree extends StatefulWidget {
  const HuffmanTree(
      {Key? key, required this.tree, required this.frequencyTable})
      : super(key: key);

  final MapEntry<Node, int> tree;
  final Map<Node, int> frequencyTable;

  @override
  _HuffmanTreeState createState() => _HuffmanTreeState();
}

class _HuffmanTreeState extends State<HuffmanTree> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 1000,
      ),
      painter: HuffmanTreePainter(MediaQuery.of(context).size.width,
          widget.tree, widget.frequencyTable),
    );
  }
}

class HuffmanTreePainter extends CustomPainter {
  HuffmanTreePainter(this.width, this.huffmanTree, this.frequencyTable);

  final double width;
  final MapEntry<Node, int> huffmanTree;
  final Map<Node, int> frequencyTable;

  Paint _paint = Paint()..color = Colors.blue;
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(width / 2, 50);

    List<int> code = [];
    Node? rootNode = huffmanTree.key;
    List<Node> stack = [];
    List<Node> visited = [];
    Map<String, String> huffmanCodeTable = {};

    Offset level = center;
    Offset previousLevel = center;
    int height = 1;
    double maxPathWidth = size.width / 3.5;

    stack.add(rootNode);
    // canvas..drawCircle(center, 20, _paint);
    while (stack.isNotEmpty) {
      Node currentNode = stack.last;
      canvas.drawCircle(level, 15, _paint);
      String textToPaint = currentNode.key.length == 1
          ? currentNode.key
          : currentNode.key.split('').fold(
              '0',
              (previousValue, currentValue) =>
                  '${int.parse(previousValue) + frequencyTable.entries.firstWhere((element) => element.key.key == currentValue).value}');
      paintText(
        canvas,
        level,
        textToPaint,
      );
      canvas.drawLine(previousLevel, level, _paint);

      previousLevel = level;

      if (currentNode.left == null && currentNode.right == null) {
        huffmanCodeTable.addAll({currentNode.key: code.join()});
        code.removeLast();

        height -= 2;
        var removed = stack.removeLast();
        if (removed == stack.last.left) {
          level = level.translate(maxPathWidth / height, -100);
        } else if (removed == stack.last.right) {
          level = level.translate(-maxPathWidth / height, -100);
        }
      } else if (currentNode.left != null &&
          !visited.contains(currentNode.left)) {
        code.add(0);
        currentNode = currentNode.left!;
        visited.add(currentNode);
        stack.add(currentNode);
        level = level.translate(-maxPathWidth / height, 100);
        height += 2;
      } else if (currentNode.right != null &&
          !visited.contains(currentNode.right)) {
        code.add(1);
        currentNode = currentNode.right!;
        visited.add(currentNode);
        stack.add(currentNode);
        level = level.translate(maxPathWidth / height, 100);
        height += 2;
      } else {
        if (code.isNotEmpty) {
          code.removeLast();
        }
        var removed = stack.removeLast();
        if (stack.isNotEmpty) {
          height -= 2;
          if (removed == stack.last.left) {
            level = level.translate(maxPathWidth / height, -100);
          } else if (removed == stack.last.right) {
            level = level.translate(-maxPathWidth / height, -100);
          }
        }
      }
    }
  }

  void paintText(Canvas canvas, Offset offset, String text) {
    TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '$text',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    tp.layout();
    tp.paint(canvas, offset.translate(-10, -10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
