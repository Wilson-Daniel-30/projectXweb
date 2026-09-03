
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';

class ProductDetailScreenViewModel extends ChangeNotifier{
  final ProductViewModel;
  final FlashSaleViewModel;

  ProductDetailScreenViewModel({
    required this.ProductViewModel,
    required this.FlashSaleViewModel,
  }) {
    combineDataIfAvailable();
  }


  bool isLoading = true;
  List<ProductModel> combinedList = [];

  void combineDataIfAvailable() {


    if (ProductViewModel.products != null && FlashSaleViewModel.flashSaleProducts != null) {
      final Map<String, ProductModel> uniqueMap = {};

      // Add flash sale products
      for (var product in FlashSaleViewModel.flashSaleProducts) {
        uniqueMap[product.title] = product;
      }

      // Add regular products (only if not already present)
      for (var product in ProductViewModel.products) {
        uniqueMap[product.title] = product;
      }

      // Convert map values to list and shuffle
      combinedList = uniqueMap.values.toList()..shuffle();

      isLoading = false;
      notifyListeners();
    } else {
      // waitForData();
    }
    print(ProductViewModel.products);
    print("combinedList $combinedList");
  }

  // Future<void> waitForData() async {
  //   // You can use Future.wait, streams, or notify from A/B viewmodels
  //   final productVM = ProductViewModel();
  //   final flashSaleVM = FlashSaleViewModel();
  //
  //   await Future.wait([
  //     productVM.fetchProducts(),
  //     flashSaleVM.fetchProducts(),
  //   ]);
  //
  //   combineDataIfAvailable();
  // }

}