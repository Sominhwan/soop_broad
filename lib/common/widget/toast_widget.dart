
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToastWidget {
  /// [longLength] is used to show the toast for the longer period.
  static const int longLength = 1;

  /// [shortLength] is used to show the toast for the shorter period.
  static const int shortLength = 0;

  static const MethodChannel _channel = MethodChannel('native_toast');

  /// [makeText] is the function responsible to show the toast natively.
  /// [message] is the required parameter inorder to show the text message.
  /// [duration] is the optional parameter to set how log a [Toast] is show.
  /// by default it is set to [shortLength]
  Future<void> makeText(
      {required String message, int duration = shortLength}) async {
    if (Platform.isAndroid) {
      try {
        await _channel.invokeMethod("showToast", {
          "message": message,
          "duration": duration,
        });
      } catch (error) {
        rethrow;
      }
    } else {
      throw "NativeToast is plugin only made for Android.";
    }
  }
}
