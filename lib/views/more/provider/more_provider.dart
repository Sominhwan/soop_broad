
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:soop_broad/common/loading/custom_loading.dart';
import 'package:soop_broad/views/more/api/more_api.dart';

import '../../../utils/loading_message.dart';

class MoreProvider extends ChangeNotifier {
  String? data;

  Future<void> getTestData() async {
    try {
      var response = await MoreApi().getNotice({'clntId': 'test'}).wrapLoading(constMsgLoading);
      data = response;

      notifyListeners();
    } finally {}
  }
}