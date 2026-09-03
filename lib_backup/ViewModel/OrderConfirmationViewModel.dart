import 'package:flutter/material.dart';
import 'package:projectx/models/OrderInfo.dart';
import 'package:projectx/Admin/DataBaseServices.dart';

class OrderConfirmationViewModel extends ChangeNotifier {
  late OrderInfo _orderInfo;

  OrderInfo get orderInfo => _orderInfo;

  void setOrderInfo(OrderInfo info) {
    _orderInfo = info;
    DataBaseServices().sendOrderInfo(info);

    notifyListeners();
  }
}
