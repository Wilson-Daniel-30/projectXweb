import 'package:projectx/models/CartItemModel.dart';
import 'package:projectx/models/CartItemNameCountInfo.dart';

class OrderInfo {
  final String orderNumber;
  final String paymentId;
  final double amountPaid;
  final List<CartItemNameCountInfo> cartItems;
  final String userName;
  final String userEmail;
  final String userAddress;
  final String dateTime;

  OrderInfo({
    required this.userName,
    required this.userEmail,
    required this.orderNumber,
    required this.paymentId,
    required this.amountPaid,
    required this.userAddress,
    required this.cartItems,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'orderNumber': orderNumber,
      'paymentId': paymentId,
      'amountPaid': amountPaid,
      'userAddress': userAddress,
      'dateTime': dateTime,
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}
