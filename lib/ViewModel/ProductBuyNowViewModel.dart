import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:projectx/models/CartItemModel.dart';

class ProductBuyNowViewModel extends ChangeNotifier {
  final ProductModel productModel;
  final CartViewModel cartViewModel;

  int _noOfItem = 0;
  int _selectedSizeIndex = 0;
  bool showed = false;
  bool totalShowed = false;

  ProductBuyNowViewModel({
    required this.productModel,
    required this.cartViewModel,
  });

  int get noOfItem {
    final match = cartViewModel.cartItems.firstWhere(
          (item) => item.product.title == productModel.title,
      orElse: () => CartItemModel(product: productModel, quantity: _noOfItem),
    );
    if(_noOfItem < match.quantity){
      if(!showed) {
        print("NotShownShowing");
        _noOfItem = match.quantity;
        showed = true;
      }
    }
    return _noOfItem;
  }
  int get selectedSizeIndex => _selectedSizeIndex;

  double get unitPrice => productModel.priceAfterDiscount ?? productModel.price;

  double get totalPrice {
    final match = cartViewModel.cartItems.firstWhere(
          (item) => item.product.title == productModel.title,
      orElse: () => CartItemModel(product: productModel, quantity: _noOfItem),
    );
    if(!totalShowed){
      totalShowed = true;
      return unitPrice * match.quantity;
    }

    return unitPrice * _noOfItem;
  }

  void incrementItem() {
    _noOfItem++;
    print("totalItems $_noOfItem");
    notifyListeners();
  }

  void decrementItem() {
    if (_noOfItem > 0) {
      _noOfItem--;
      print("totalItems $_noOfItem");
      notifyListeners();
    }
  }

  void selectSize(int index) {
    _selectedSizeIndex = index;
    notifyListeners();
  }

  void addToCart() {
    print(StackTrace.current);
    print("addToCart $_noOfItem");

    cartViewModel.removeFromCart(productModel);
    cartViewModel.addToCart(productModel, _noOfItem);
  }
}

