
import 'package:flutter/material.dart';

class CustomThemeMode {
  static final CustomThemeMode instance = CustomThemeMode._internal();
  factory CustomThemeMode() => instance;

  static ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static ValueNotifier<bool> current = ValueNotifier(true);

  static void change() {
    switch (themeMode.value) {
      case ThemeMode.light:
        themeMode.value = ThemeMode.dark;
        current.value = false;
        break;
      case ThemeMode.dark:
        themeMode.value = ThemeMode.light;
        current.value = true;
        break;
      default:
    }
  }

  CustomThemeMode._internal();
}