part of huffman;

/// [HuffmanCode] is a model calss that represent a Huffman Encoded Value.
@immutable
class HuffmanCode {
  final String value;
  final Map<String, String> huffmanTable;

  HuffmanCode(this.value, this.huffmanTable);
}
