import 'package:flutter/material.dart';
import 'package:stok_takip/helper/messagehelper.dart';

class Helper {
  


  // Map'i kabul eden items metodu


  static Future<void> handleOperation({
    required Future<void> Function() operation,
    required String successMessage,
    required BuildContext context,
  }) async {
    try {
      await operation();
      MessageHelper.showSnackBar(context, successMessage);
    } catch (e) {
      MessageHelper.showSnackBar(context, 'İşlem sırasında bir hata oluştu.');
    }
  }

}