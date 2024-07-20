import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToastMessage {
  void showLongToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
        backgroundColor: Colors.white,
        textColor: Colors.black);
  }
}
