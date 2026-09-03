import 'package:cloud_firestore/cloud_firestore.dart';

class AppInfo {
  String? saleTime;
  String? saleDiscountPercentage;

  AppInfo({this.saleTime,this.saleDiscountPercentage});

  AppInfo.fromJson(Map<String, dynamic> json) {
    final timestamp = json['SaleTime'];
    if (timestamp is Timestamp) {
      saleTime = timestamp.toDate().toIso8601String();
      print("saleTime");
      print(saleTime);
    } else if (timestamp is String) {
      saleTime = timestamp;
    }

    final discount = json['SaleDiscountPercentage'];
    print("saleDiscountPercentage");
    print(discount);

    // Assign to instance variable!
    saleDiscountPercentage = discount?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (saleTime != null) {
      data['SaleTime'] = saleTime; // optional: convert back to Timestamp if needed
    }
    if(saleDiscountPercentage != null){
      data['SaleDiscountPercentage'] = saleDiscountPercentage;
    }
    return data;
  }
}