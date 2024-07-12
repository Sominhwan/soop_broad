
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
    ),
    drawerTheme: const DrawerThemeData(
      endShape: LinearBorder.none,
      backgroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.black)
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
    ),
    drawerTheme: const DrawerThemeData(
      endShape: LinearBorder.none,
      backgroundColor: Color.fromRGBO(50, 50, 50, 1),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
  );

  static const TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
  );

  static const TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  );
}