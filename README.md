# Huffman Coding Library

A library to perform huffman encoding and decoding.

Huffman Coding is a text compression technique invented by David A. Huffman in 1952.
It is a loseless data compression algorithm. i.e Original data can be perfectly reconstructed/decoded from the compressed/encoded data. Huffman coding generates a prefix code by converting characters into variable length bit strings. The most frequently occurring characters are converted to the shortest bit strings; the least frequently occurring characters are converted to the longest bit strings. 

__See Project Demo:__ [Demo](https://aadarshadhakalg.github.io/huffman-dart/)<br>
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

 ## License

The source code for the site is licensed under the MIT license, which you can find in the LICENSE file.
All graphical assets are licensed under the [Creative Commons Attribution 3.0 Unported License](https://creativecommons.org/licenses/by/3.0/).
