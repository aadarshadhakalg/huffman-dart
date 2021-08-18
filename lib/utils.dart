part of huffman;

/// Utils contains the utility functions for huffman coding.
///
/// Available methods:
/// [insertionSort] Sort the map using insertion sort algorithm
/// Insettion sort is used by [makeFrequencyTable]
///
/// [makeFrequencyTable] : Makes frequency table from input string
///
class _Utils {
  /// Sort the map using insertion sort algorithm.
  ///
  /// Insertion sort is stable sort so it is used.
  /// This methos return sorted frequency table.
  static Map<_Node, int> insertionSort(Map<_Node, int> map) {
    // Map to entries list conversion
    List<MapEntry<_Node, int>> list = map.entries.toList();

    // If there are no entries return empty map
    if (list.isEmpty) return {};

    // If there are entries in map then perform insertion sort
    // Sorting order is Descending
    int n = list.length;
    int i, j;
    MapEntry<_Node, int> temp;

    for (i = 1; i < n; i++) {
      temp = list[i];
      j = i - 1;
      while (j >= 0 && temp.value <= list[j].value) {
        list[j + 1] = list[j];
        --j;
      }
      list[j + 1] = temp;
    }

    // Return's the sorted map
    return Map.fromEntries(list.reversed);
  }

  /// Makes frequency table from the input string
  ///
  /// Uses [insertionSort] method to sort the table
  /// This methos returns the huffman frequency table which is sorted.
  static Map<_Node, int> makeFrequencyTable(String string) {
    // Map as a frequency table
    var freq = <_Node, int>{};

    // Make frequency table
    for (var char in string.split('')) {
      if (!freq.containsKey(_Node(key: char))) {
        freq[_Node(key: char)] = 1;
      } else {
        freq[_Node(key: char)] = freq[_Node(key: char)]! + 1;
      }
    }

    // Sort the frequency table and return
    return insertionSort(freq);
  }

  /// Generate huffman code table.
  ///
  /// Takes huffman tree of type [MapEntry] as input.
  ///
  /// This method performs depth first Traverse on the huffman tree and generates
  /// huffman code table of type [Map] and returns it.
  static Map<String, String> getHuffmanCodeTable(MapEntry<_Node, int> tree) {
    // Holds huffman code for a character
    List<int> code = [];
    // Holds the root node of huffman tree
    _Node? rootNode = tree.key;
    // Holds path to current node
    List<_Node> stack = [];
    // Holds all visited nodes
    List<_Node> visited = [];
    // Holds the final huffman code table
    Map<String, String> huffmanCodeTable = {};

    // Push root node in stack
    stack.add(rootNode);
    // Loops until the stack is empty
    while (stack.isNotEmpty) {
      // Assignes top of stack as current node.
      _Node currentNode = stack.last;
      if (currentNode.left == null && currentNode.right == null) {
        // If current node is leaf node,
        // add it and the equivalent huffman code to huffmanCodeTable
        huffmanCodeTable.addAll({currentNode.key: code.join()});
        // Move back one step
        code.removeLast();
        stack.removeLast();
      } else if (currentNode.left != null &&
          !visited.contains(currentNode.left)) {
        // if current node has unvisited left node,
        // visit it first and add 0 to the code then add the node in visited list.
        // push current node to stack
        code.add(0);
        currentNode = currentNode.left!;
        visited.add(currentNode);
        stack.add(currentNode);
      } else if (currentNode.right != null &&
          !visited.contains(currentNode.right)) {
        // if current node has unvisited right node,
        // visit it and add 1 to the code then add the node in visited list.
        // push current node to stack
        code.add(1);
        currentNode = currentNode.right!;
        visited.add(currentNode);
        stack.add(currentNode);
      } else {
        // If the current node has both left and right child and all are visited
        // Moves to parent node
        if (code.isNotEmpty) {
          code.removeLast();
        }
        stack.removeLast();
      }
    }

    // Finally returns the huffman code table
    return huffmanCodeTable;
  }

  /// Builds heap/huffman tree from the frequency table.
  ///
  /// Takes frequencytable of type [Map] as input.
  ///
  /// This method uses recursive strategy to build Priority Queue or Heap or
  /// Huffman Tree from frequency table and returns it.
  static MapEntry<_Node, int> buildHeap(Map<_Node, int> frequencyTable) {
    if (frequencyTable.entries.length == 1) {
      return frequencyTable.entries.first;
    }

    // Get all entries from map
    List<MapEntry<_Node, int>> allEntries = frequencyTable.entries.toList();
    // Finds last entry
    MapEntry<_Node, int> lastEntry = allEntries.last;
    // Finds second last entry
    MapEntry<_Node, int> secondLastEntry = allEntries[allEntries.length - 2];

    // Create a parent node for last 2 entries
    _Node parent = _Node(
      key: secondLastEntry.key.key + lastEntry.key.key,
      right: lastEntry.key,
      left: secondLastEntry.key,
    );
    // Calculate Freuency of parent node
    int parentFrequency = lastEntry.value + secondLastEntry.value;

    // Create map entry for parent node
    MapEntry<_Node, int> connect = MapEntry(parent, parentFrequency);

    // Modify map
    // Replace last 2 entry with the parent node entry
    List<MapEntry<_Node, int>> newLevel =
        allEntries.sublist(0, allEntries.length - 2)..add(connect);

    // Sort the map of new level
    Map<_Node, int> sortedNewLevel =
        _Utils.insertionSort(Map.fromEntries(newLevel));

    // Recursvely build the next level of Heap
    return buildHeap(sortedNewLevel);
  }
}
