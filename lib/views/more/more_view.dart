
import 'package:flutter/material.dart';

import '../../utils/custom_theme_mode.dart';

class MoreView extends StatefulWidget {
  const MoreView({super.key});

  @override
  State<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends State<MoreView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CustomThemeMode.current,
      builder: (context, value, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: value ? const Color.fromRGBO(240, 240, 240, 1) : const Color.fromRGBO(30, 30, 30, 1),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
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
