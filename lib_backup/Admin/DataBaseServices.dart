import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/models/OrderInfo.dart';


class DataBaseServices{
  final _fire = FirebaseFirestore.instance;

  Future<void> createProduct(ProductModel productModel) async {
    try {
      await _fire.collection("Products").add(productModel.toJson());
      print("Product added successfully.");
    } catch (e) {
      print("createProduct error");
      print(e.toString());
    }
  }

  Future<void> sendOrderInfo(OrderInfo orderInfo) async {
    try {
      await _fire.collection("Orders").add(orderInfo.toJson());
      print("Order Sent to firebase successfully.");
    } catch (e) {
      print("Order Sent error");
      print(e.toString());
    }
  }
}