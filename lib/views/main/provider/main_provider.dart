
import 'dart:io';
import 'package:flutter/cupertino.dart';

enum Page { HOME, SPORTS, MY, MORE  }

class MainProvider extends ChangeNotifier {
  int page = 0;
  List<int> bottomHistory = [0];  // 타입 명시
  String appBarTitle = '메인';

  void changeIndex(int value) {
    var page = Page.values[value];
    switch (page) {
      case Page.HOME:
        appBarTitle = '메인';
        moveTo(value);
        break;
      case Page.SPORTS:
        appBarTitle = '스포츠';
        moveTo(value);
        break;
      case Page.MY:
        appBarTitle = 'MY';
        moveTo(value);
        break;
      case Page.MORE:
        appBarTitle = '더보기';
        moveTo(value);
        break;
    }
  }

  void moveTo(int value) {
    if (page != value) {
      page = value;
      if (!bottomHistory.contains(value) && Platform.isAndroid || Platform.isIOS) {
        bottomHistory.add(value);
      }
      notifyListeners();
    }
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length > 1) {
      bottomHistory.removeLast();
      page = bottomHistory.last;
      appBarTitle = getAppBarTitle(page);
      notifyListeners();
      return false;
    } else {
      appBarTitle = '메인';
      return true;
    }
  }

  String getAppBarTitle(int pageIndex) {
    switch (pageIndex) {
      case 0: return '메인';
      case 1: return '스포츠';
      case 2: return 'MY';
      case 3: return '더보기';
      default: return 'SOOP';
    }
  }

  void onDispose() {
    page = 0;
    bottomHistory.clear();
  }
}