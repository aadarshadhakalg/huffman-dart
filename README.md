# Huffman Coding Library

A library to perform huffman encoding and decoding.

Huffman Coding is a text compression technique invented by David A. Huffman in 1952.
It is a loseless data compression algorithm. i.e Original data can be perfectly reconstructed/decoded from the compressed/encoded data. Huffman coding generates a prefix code by converting characters into variable length bit strings. The most frequently occurring characters are converted to the shortest bit strings; the least frequently occurring characters are converted to the longest bit strings. 

__See Project Demo:__ [Demo](https://huffman.aadarshadhakal.com.np/)<br>
__See Project Documentation:__ [Documentation](https://aadarshadhakalg.github.io/huffman-dart/)<br>
__See Example App:__ [Example App](https://github.com/aadarshadhakalg/huffman-dart/tree/master/example)<br><br>

  

## Features
 * Encode String
 * Decode [HuffmanCode]
<br>
<br>

## Usage

 1. Create a instance of [HuffmanCoding]
 ```dart
 HuffmanCoding huffmanCoding = HuffmanCoding();
 ```

 2. Encode
 ```dart
 HuffmanCode encoded = huffmanCoding.encode('Hello');
 ```

 3. Decode
 ```dart
 String decoded = huffmanCoding.decode(encoded);
 ```
 <br>
 <br>

## Time Complexity Analysis
<br>

### Encoding
  
 `T(n) = nlogn + logn + n + n => O(nlogn)`

 ```dart
  HuffmanCode encode(String toEncode) {
    // Time Complexity:  O(nlogn)
    frequencyTable = _Utils.makeFrequencyTable(toEncode);
    // Time Complexity: O(logn)
    tree = _Utils.buildHeap(frequencyTable);
    // Time Complexity: O(n)
    Map<String, String> huffmanTable = _Utils.getHuffmanCodeTable(tree);
    // Time Complexity: O(n)
    var encodedValue = toEncode.split('').fold(
        '',
        (previousValue, element) =>
            previousValue.toString() + huffmanTable[element]!);
    return HuffmanCode(encodedValue, huffmanTable);
  }
 ```
<br>

### Decoding

 `T(n) = n^2 + 2 => O(n^2)`

 ```dart
  String decode(HuffmanCode toDecode) {
    Map<String, String> huffmanTable = toDecode.huffmanTable;
    String decodedValue = '';
    // Time Complexity O(n^2)
    toDecode.value.split('').fold(
      '',
      (previousValue, currentValue) {
        if (huffmanTable
            .containsValue(previousValue.toString() + currentValue)) {
          decodedValue = decodedValue +
              huffmanTable.entries
                  .firstWhere((element) =>
                      element.value ==
                      (previousValue.toString() + currentValue))
                  .key;
          return '';
        } else {
          return previousValue.toString() + currentValue;
        }
      },
    );
    return decodedValue;
  }

 ```

 ## License

The source code for the site is licensed under the MIT license, which you can find in the LICENSE file.
All graphical assets are licensed under the [Creative Commons Attribution 3.0 Unported License](https://creativecommons.org/licenses/by/3.0/).
