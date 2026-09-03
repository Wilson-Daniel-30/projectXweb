import '../models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MostPopularViewModel extends ChangeNotifier{
  final List<ProductModel> _mostPopularProducts = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get mostPopularProducts => _mostPopularProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<List<ProductModel>> fetchMostPopularProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // try{
      final snapshot = await FirebaseFirestore.instance.collection('Products').get();
      _mostPopularProducts.clear();
      _mostPopularProducts.addAll(
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data()))
            .where((product) =>
        product.mostPopular != null &&
            product.mostPopular == true) // Optional: filter out "0"%
            .toList(),

      );
    // }catch(e){
    //   _error = e.toString();
    // }
    print("_mostPopularProducts $_mostPopularProducts");
    _isLoading = false;
    notifyListeners();
    return _mostPopularProducts;
  }
}