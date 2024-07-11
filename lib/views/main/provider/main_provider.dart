
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum Page { HOME, SPORTS, MYPAGE, ADD  }

class MainProvider extends ChangeNotifier {
  int page = 0;

  List bottomHistory = [0];

  void changeIndex(int value) {
    var page = Page.values[value];
    switch (page) {
      case Page.HOME:
      case Page.SPORTS:
      case Page.MYPAGE:
      case Page.ADD:
        moveTo(value);
    }
  }

  void moveTo(int value) {
    page = value;
    if (bottomHistory.last != value && Platform.isAndroid) {
      bottomHistory.add(value);
    }
    notifyListeners();
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      return true;
    } else {
      bottomHistory.removeLast();
      page = bottomHistory.last;
      return false;
    }
  }

  void onInit() {}

  void onDispose() {
    page = 0;
  }
}
