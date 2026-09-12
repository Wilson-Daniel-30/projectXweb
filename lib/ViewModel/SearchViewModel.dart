import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/components/product/product_card.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/Screens/search/views/components/search_form.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/ViewModel/SearchViewModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectx/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb
import 'package:projectx/Screens/search/views/search_screen.dart';

class SearchViewModel extends ChangeNotifier {
  final List<ProductModel> _allProducts;
  List<ProductModel> _filteredProducts = [];

  SearchViewModel(this._allProducts) {
    _filteredProducts = List.from(_allProducts);
  }

  List<ProductModel> get filteredProducts => _filteredProducts;

  void search(String query) {
    // for(int i=0 ; i<_allProducts.length ; i++){
    //   print("${_allProducts[i].title}")
    // }
    _filteredProducts = _allProducts
        .where((product) =>
    product.title.toLowerCase().contains(query.toLowerCase()) ||
        product.title.toLowerCase().contains(query.toLowerCase()))
        .toList()..shuffle();
    print("query $query");
    print(_filteredProducts);
    notifyListeners();
  }
}