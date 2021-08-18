part of huffman;

/// [_Node] is a model calss that represent a node of Huffman Tree.
@immutable
class _Node {
  final _Node? left;
  final _Node? right;
  final String key;

  _Node({this.left, this.right, required this.key});

  // Overtide equals for map comparision
  // Should override hashcode also

  @override
  bool operator ==(Object another) {
    if (another is _Node) {
      return key == another.key;
    }
    return false;
  }

  @override
  int get hashCode => key.hashCode;
}
