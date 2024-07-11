
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum Page { HOME, SPORTS, MY, MORE  }

class MainProvider extends ChangeNotifier {
  int page = 0;

  List bottomHistory = [0];
  String appBarTitle = 'SOOP';

  void changeIndex(int value) {
    var page = Page.values[value];
    switch (page) {
      case Page.HOME:
        appBarTitle = 'SOOP';
        moveTo(value);
      case Page.SPORTS:
        appBarTitle = '스포츠';
        moveTo(value);
      case Page.MY:
        appBarTitle = 'MY';
        moveTo(value);
      case Page.MORE:
        appBarTitle = '더보기';
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
      print('진실');
      return true;
    } else {
      bottomHistory.removeLast();
      page = bottomHistory.last;
      print('거짓${page}');
      notifyListeners();
      return false;
    }
  }

  void onInit() {}

  void onDispose() {
    page = 0;
  }
}
