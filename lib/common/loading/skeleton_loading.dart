
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/custom_theme_mode.dart';

class SkeletonLoading {
  /// 메인 스켈레톤 로딩바
  Widget mainSkeletonLoader() {
    return ValueListenableBuilder<bool>(
      valueListenable: CustomThemeMode.current, // 테마 변경 감지
      builder: (context, value, child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Shimmer.fromColors(
                  baseColor: value ? const Color.fromRGBO(245, 245, 245, 1) : const Color.fromRGBO(70, 70, 70, 1),
                  highlightColor: value ? const Color.fromRGBO(250, 250, 250, 1) : const Color.fromRGBO(75, 75, 75, 1),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: value ? const Color.fromRGBO(245, 245, 245, 1) : const Color.fromRGBO(70, 70, 70, 1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 45,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: value ? const Color.fromRGBO(245, 245, 245, 1) : const Color.fromRGBO(70, 70, 70, 1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 220,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: value ? const Color.fromRGBO(245, 245, 245, 1) : const Color.fromRGBO(70, 70, 70, 1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 150,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: value ? const Color.fromRGBO(245, 245, 245, 1) : const Color.fromRGBO(70, 70, 70, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  /// 추후 필요한 각 화면별 로딩바 추가
}