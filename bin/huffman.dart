import 'package:huffman/huffman.dart';

void main(List<String> arguments) {
  HuffmanCoding huffmanCoding = HuffmanCoding();

  HuffmanCode encoded = huffmanCoding.encode('Hello');

  String decoded = huffmanCoding.decode(encoded);
  print(decoded);
}
