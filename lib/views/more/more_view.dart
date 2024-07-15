
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soop_broad/common/loading/custom_loading.dart';
import 'package:soop_broad/utils/loading_message.dart';

import '../../utils/custom_theme_mode.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  Future<void> test() async {
    await Future.delayed(const Duration(seconds: 1), () {
      log('test');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CustomThemeMode.current,
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: value ? const Color.fromRGBO(240, 240, 240, 1) : const Color.fromRGBO(40, 40, 40, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          test().wrapLoading(constMsgLoading);
                        },
                        child: const Text('테스트'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
