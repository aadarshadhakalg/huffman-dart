import 'package:huffman/huffman.dart';
import 'package:test/test.dart';

void main() {
  HuffmanCoding huffmanCoding = HuffmanCoding();

  test('encode', () {
    expect(huffmanCoding.encode('Hello').runtimeType, HuffmanCode);
  });

  test('decode', () {
    var encoded = huffmanCoding.encode('Hello');
    expect(huffmanCoding.decode(encoded).runtimeType, String);
  });
}
