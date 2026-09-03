
class CartItemNameCountInfo{
  String name;
  int count;
  CartItemNameCountInfo({required this.name,required this.count});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'count': count,
    };
  }
}