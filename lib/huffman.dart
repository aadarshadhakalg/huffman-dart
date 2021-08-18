/// A library to perform huffman encoding and decoding.
///
/// __Features__
/// * Encode String
/// * Decode [HuffmanCode]
///
/// __Usage__
///
/// 1. Create a instance of [HuffmanCoding]
/// ```dart
/// HuffmanCoding huffmanCoding = HuffmanCoding();
/// ```
///
/// 2. Encode
/// ```dart
/// HuffmanCode encoded = huffmanCoding.encode('Hello');
/// ```
///
/// 3. Decode
/// ```dart
/// String decoded = huffmanCoding.decode(encoded);
/// ```
///
/// Project Github: * https://github.com/aadarshadhakalg/huffman-dart
///

library huffman;

import 'package:meta/meta.dart';

part 'types/node.dart';
part 'types/huffman_code.dart';
part 'utils.dart';

class HuffmanCoding {
  HuffmanCoding();
  late Map<_Node, int> frequencyTable;
  late MapEntry<_Node, int> tree;

  /// Encodes the input strng using huffman encoding algorithm.
  ///
  /// Takes input of type [String] as input to encode it.
  ///
  /// This method returns [HuffmanCode] which contains the encoded value and
  /// equivalent huddman code table which is required to decode the encoded value.
  HuffmanCode encode(String toEncode) {
    // Get Frequency table
    frequencyTable = _Utils.makeFrequencyTable(toEncode);
    // Builds heap tree
    tree = _Utils.buildHeap(frequencyTable);
    // Perform DFS to generate huffman code table
    Map<String, String> huffmanTable = _Utils.getHuffmanCodeTable(tree);

    // Replace characters with huffman value
    var encodedValue = toEncode.split('').fold(
        '',
        (previousValue, element) =>
            previousValue.toString() + huffmanTable[element]!);

    // Returns huffman code containing encoded value and equivalent huffman table.
    return HuffmanCode(encodedValue, huffmanTable);
  }

  /// Decodes the huffman code
  ///
  /// Takes input of type [HuffmanCode] as input to decode it.
  ///
  /// This method decoded the `HuffmanCode` and returns decoded value of type [String]
  String decode(HuffmanCode toDecode) {
    // Holds  huffman table which is used for decoding
    Map<String, String> huffmanTable = toDecode.huffmanTable;

    // Holds decoded value
    String decodedValue = '';

    // Splits encoded value into characters and aggregate them one by one.
    toDecode.value.split('').fold(
      '',
      (previousValue, currentValue) {
        // While aggregating it checks if the current aggregate is present in huffman table.
        if (huffmanTable
            .containsValue(previousValue.toString() + currentValue)) {
          // If current aggregate is present in huffman table,
          // append it to `decodedValue` and clear the aggregate value.
          decodedValue = decodedValue +
              huffmanTable.entries
                  .firstWhere((element) =>
                      element.value ==
                      (previousValue.toString() + currentValue))
                  .key;
          return '';
        } else {
          // If current aggregate is not present in huffman table,
          // move to next iteration
          return previousValue.toString() + currentValue;
        }
      },
    );
    return decodedValue;
  }
}
