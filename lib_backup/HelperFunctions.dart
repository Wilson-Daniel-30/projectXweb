import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/constants.dart';
import 'dart:math';


class HelperFunctions{

  static String generateOrderId() {
    final random = Random();
    String orderId = '';
    for (int i = 0; i < 16; i++) {
      orderId += random.nextInt(10).toString(); // Random digit from 0–9
    }
    return orderId;
  }

  static void showSnackBar(BuildContext context,String text,int duration){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: primaryColor, // professional dark tone
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),

      ),
    );
  }
}