part of huffman;

/// Utils contains the utility functions for huffman coding.
///
/// Available methods:
/// [insertionSort] Sort the map using insertion sort algorithm
/// Insettion sort is used by [makeFrequencyTable]
///
/// [heapSort] Sort the map using heap sort algorithm
/// Insettion sort is used by [makeFrequencyTable]
///
/// [makeFrequencyTable] : Makes frequency table from input string
///
class _Utils {
  /// Sort the map using insertion sort algorithm.
  ///
  /// Insertion sort is no more used, because of it's time complexity O(n^2).
  /// This methos return sorted frequency table.
  @Deprecated('Use heapSort() instead')
  static Map<Node, int> insertionSort(Map<Node, int> map) {
    // Map to entries list conversion
    List<MapEntry<Node, int>> list = map.entries.toList();

    // If there are no entries return empty map
    if (list.isEmpty) return {};

    // If there are entries in map then perform insertion sort
    // Sorting order is Descending
    int n = list.length;
    int i, j;
    MapEntry<Node, int> temp;

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
  /// Uses [heapSort] method to sort the table
  /// This methos returns the huffman frequency table which is sorted.
  static Map<Node, int> makeFrequencyTable(String string) {
    // Map as a frequency table
    var freq = <Node, int>{};

    // Make frequency table
    for (var char in string.split('')) {
      if (!freq.containsKey(Node(key: char))) {
        freq[Node(key: char)] = 1;
      } else {
        freq[Node(key: char)] = freq[Node(key: char)]! + 1;
      }
    }

    // Sort the frequency table and return

    return heapSort(freq);
  }

  /// Generate huffman code table.
  ///
  /// Takes huffman tree of type [MapEntry] as input.
  ///
  /// This method performs depth first Traverse on the huffman tree and generates
  /// huffman code table of type [Map] and returns it.
  static Map<String, String> getHuffmanCodeTable(MapEntry<Node, int> tree) {
    // Holds huffman code for a character
    List<int> code = [];
    // Holds the root node of huffman tree
    Node? rootNode = tree.key;
    // Holds path to current node
    List<Node> stack = [];
    // Holds all visited nodes
    List<Node> visited = [];
    // Holds the final huffman code table
    Map<String, String> huffmanCodeTable = {};

    // Push root node in stack
    stack.add(rootNode);
    // Loops until the stack is empty
    while (stack.isNotEmpty) {
      // Assignes top of stack as current node.
      Node currentNode = stack.last;
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
  static MapEntry<Node, int> buildHeap(Map<Node, int> frequencyTable) {
    if (frequencyTable.entries.length == 1) {
      return frequencyTable.entries.first;
    }

    // Get all entries from map
    List<MapEntry<Node, int>> allEntries = frequencyTable.entries.toList();
    // Finds last entry
    MapEntry<Node, int> lastEntry = allEntries.last;
    // Finds second last entry
    MapEntry<Node, int> secondLastEntry = allEntries[allEntries.length - 2];

    // Create a parent node for last 2 entries
    Node parent = Node(
      key: secondLastEntry.key.key + lastEntry.key.key,
      right: lastEntry.key,
      left: secondLastEntry.key,
    );
    // Calculate Freuency of parent node
    int parentFrequency = lastEntry.value + secondLastEntry.value;

    // Create map entry for parent node
    MapEntry<Node, int> connect = MapEntry(parent, parentFrequency);

    // Modify map
    // Replace last 2 entry with the parent node entry
    List<MapEntry<Node, int>> newLevel =
        allEntries.sublist(0, allEntries.length - 2)..add(connect);

    // Sort the map of new level
    Map<Node, int> sortedNewLevel = _Utils.heapSort(Map.fromEntries(newLevel));

    // Recursvely build the next level of Heap
    return buildHeap(sortedNewLevel);
  }

  /// Sort the map using heap sort algorithm.
  ///
  /// This methos return sorted frequency table.
  /// Time Complexity O(nlogn)
  static Map<Node, int> heapSort(Map<Node, int> freq) {
    // Map to entries list conversion
    List<MapEntry<Node, int>> list = freq.entries.toList();

    // Holds length of entries
    int n = list.length;

    // Heap Building Part
    // Since leaf nodes are already a heap configuration we do not have to perform any operation.
    // So we perform operation to non leaf nodes only which are first (n/2) elements.
    for (int i = (n ~/ 2); i >= 0; i--) {
      heapify(list, n, i);
    }

    // Sorting Part
    // Perform delete operation on the heap, it will sort the list
    for (int i = n - 1; i >= 0; i--) {
      swap(list, i);
      heapify(list, i, 0);
    }

    // Return the sorted list
    return Map.fromEntries(list);
  }

  // For delete operation on heap, swap root with last node in heap
  static void swap(List<MapEntry<Node, int>> list, int i) {
    var temp = list[0];
    list[0] = list[i];
    list[i] = temp;
  }

  /// Build's min heap from the given list of items.
  /// Time Complexity O(logn)
  static void heapify(List<MapEntry<Node, int>> list, int sizeOfHeap, int i) {
    int smallest = i;
    int l = 2 * i;
    int r = 2 * i + 1;

    // If left child is smaller than root
    if (l < sizeOfHeap && list[l].value < list[smallest].value) {
      smallest = l;
    }

    // If right child is smaller than root
    if (r < sizeOfHeap && list[r].value < list[smallest].value) {
      smallest = r;
    }

    // If root is greater than its children, it doesnot satisfies the min heap
    // property so we have to swap their position and re heapify
    if (smallest != i) {
      swapInList(list, i, smallest);
      heapify(list, sizeOfHeap, smallest);
    }
  }

  // Swap item from one index in list to another index
  // Used to swap root node and child node in heap during heapify
  static void swapInList(
      List<MapEntry<Node, int>> list, int index1, int index2) {
    var temp = list[index1];
    list[index1] = list[index2];
    list[index2] = temp;
  }
}
