import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/models/CartItemModel.dart';


class CartViewModel extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  void addToCart(ProductModel product, int quantity) {
    final index = _cartItems.indexWhere((item) => item.product.title == product.title);
    if (index != -1) {
      _cartItems[index] = CartItemModel(
        product: product,
        quantity: _cartItems[index].quantity + 1,
      );
    } else {
      _cartItems.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.removeWhere((item) => item.product.title == product.title);
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.product.title == product.title);
    if (index != -1) {
      _cartItems[index] = CartItemModel(
        product: _cartItems[index].product,
        quantity: _cartItems[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.product.title == product.title);
    if (index != -1 && _cartItems[index].quantity > 1) {
      _cartItems[index] = CartItemModel(
        product: _cartItems[index].product,
        quantity: _cartItems[index].quantity - 1,
      );
      notifyListeners();
    } else if (index != -1) {
      // Optionally remove the item if quantity goes to zero
      removeFromCart(product);
    }
  }

  void clearCart() {
    print("cartItems: ${cartItems.length}");
    _cartItems.clear();
    print("cartItems: ${cartItems.length}");
    notifyListeners();
  }

  double get totalPrice => _cartItems.fold(0.0, (total, item) => total + (item.product.priceAfterDiscount ?? item.product.price) * item.quantity);
  double get mRP => _cartItems.fold(0.0, (total, item) => total + (item.product.price) * item.quantity);
}


