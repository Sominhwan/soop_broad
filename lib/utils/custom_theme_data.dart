
import 'package:flutter/material.dart';

class CustomThemeData {
  /// 라이트 모드
  static final ThemeData light = ThemeData(
    textTheme: lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.black,
      labelColor: Colors.blue,
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.1)),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Colors.blue),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400
      ),
      elevation: 5,
      enableFeedback: false,
    )
  );
  /// 다크 모드
  static final ThemeData dark = ThemeData(
    textTheme: darkTextTheme,
    scaffoldBackgroundColor: const Color.fromRGBO(45, 45, 45, 1),
    splashColor: Colors.transparent,
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.white,
      labelColor: Colors.blue,
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: WidgetStatePropertyAll(Colors.white.withOpacity(0.1)),
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Colors.blue),
      ),
    ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromRGBO(45, 45, 45, 1),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        elevation: 5,
        enableFeedback: false,
      )
  );

  static const TextTheme lightTextTheme = TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
  );

  static const TextTheme darkTextTheme = TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  );
}