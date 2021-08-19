part of huffman;

/// [Node] is a model calss that represent a node of Huffman Tree.
@immutable
class Node {
  final Node? left;
  final Node? right;
  final String key;

  Node({this.left, this.right, required this.key});

  // Overtide equals for map comparision
  // Should override hashcode also

  @override
  bool operator ==(Object another) {
    if (another is Node) {
      return key == another.key;
    }
    return false;
  }

  @override
  int get hashCode => key.hashCode;
}
