import 'dart:math';
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
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var customPainter = HuffmanTreePainter(
        MediaQuery.of(context).size.width, widget.tree, widget.frequencyTable);
    return InteractiveViewer(
      minScale: 0.1,
      maxScale: double.infinity,
      child: Center(
        child: Transform.scale(
          scale: (MediaQuery.of(context).size.width / customPainter.width) / 3,
          child: CustomPaint(
            child: Container(
              height: 500,
            ),
            painter: customPainter,
          ),
        ),
      ),
    );
  }
}

class HuffmanTreePainter extends CustomPainter {
  HuffmanTreePainter(this.width, this.huffmanTree, this.frequencyTable);

  final double width;
  final MapEntry<Node, int> huffmanTree;
  final Map<Node, int> frequencyTable;

  Paint _paint = Paint()..color = Colors.blue;
  Paint _paintLeft = Paint()
    ..color = Colors.red
    ..strokeWidth = 2;
  Paint _paintRight = Paint()
    ..color = Colors.deepPurple
    ..strokeWidth = 2;

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
    double height = 1.2;
    double maxPathWidth = size.width / 2;
    bool isMovingBack = false;

    stack.add(rootNode);
    while (stack.isNotEmpty) {
      Node currentNode = stack.last;
      if (!isMovingBack) {
        canvas.drawLine(previousLevel, level,
            (previousLevel.dx < level.dx) ? _paintLeft : _paintRight);
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
      }

      previousLevel = level;

      if (currentNode.left == null && currentNode.right == null) {
        huffmanCodeTable.addAll({currentNode.key: code.join()});
        code.removeLast();
        isMovingBack = true;

        height = sqrt(height);
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
        height = height * height;
        isMovingBack = false;
      } else if (currentNode.right != null &&
          !visited.contains(currentNode.right)) {
        code.add(1);
        currentNode = currentNode.right!;
        visited.add(currentNode);
        stack.add(currentNode);
        level = level.translate(maxPathWidth / height, 100);
        height = height * height;
        isMovingBack = false;
      } else {
        if (code.isNotEmpty) {
          code.removeLast();
        }
        var removed = stack.removeLast();
        if (stack.isNotEmpty) {
          height = sqrt(height);
          isMovingBack = true;
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
