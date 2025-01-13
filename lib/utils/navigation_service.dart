import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get globalCtx => navigatorKey.currentContext;

  static NavigatorState? get currentNavigator => navigatorKey.currentState;
}
