import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/models/AppInfo.dart';

class FlashSaleViewModel extends ChangeNotifier{
  final List<ProductModel> _flashSaleProducts = [];
  bool _isLoading = false;
  String? _error;
  late final AppInfo? appInfo;

  List<ProductModel> get flashSaleProducts => _flashSaleProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<AppInfo?> fetchAppInfo() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
      final snapshot = await FirebaseFirestore.instance.collection('AppInfo').get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data(); // Assuming only one document in 'AppInfo'
        appInfo = AppInfo.fromJson(data);
        _isLoading = false;
        notifyListeners();
        return appInfo;
      } else {
        _isLoading = false;
        _error = 'No AppInfo found';
        notifyListeners();
        return null;
      }

  }


  Future<List<ProductModel>> fetchFlashSaleProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance.collection('Products').get();
      _flashSaleProducts.clear();
      _flashSaleProducts.addAll(
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data()))
          .where((product) =>
        product.discountpercent != null &&
            product.discountpercent != '0') // Optional: filter out "0"%
            .toList()..shuffle(),
      );
    } catch (e) {
    _error = e.toString();
    }


    _isLoading = false;
    notifyListeners();
    return _flashSaleProducts;
  }

  set flashSaleProducts(List<ProductModel> value) {
    _flashSaleProducts.clear();
    _flashSaleProducts.addAll(value);
    notifyListeners();
  }

  void updateFromProductList(List<ProductModel> allProducts) {
    // Example logic: pick only flash sale products
    flashSaleProducts = allProducts.where((p) => p.discountpercent != null).toList();

    print("flashSaleProducts $_flashSaleProducts");
  }
}