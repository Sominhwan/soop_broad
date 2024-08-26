import 'package:flutter/cupertino.dart';

import 'custom_route_settings.dart';


class CustomRouteObserver extends RouteObserver<PageRoute> {
  static final CustomRouteObserver _singleton = CustomRouteObserver._internal();
  factory CustomRouteObserver() => _singleton;

  CustomRouteObserver._internal();

  String? currentRouteName;
  Object? currentArguments;

  String? previousRouteName;
  Object? previousArguments;

  BuildContext? context;

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    updateRouteInformation(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    updateRouteInformation(previousRoute, route);
  }

  void updateRouteInformation(Route? newRoute, Route? oldRoute) {
    if (newRoute is PageRoute) {
      currentRouteName = newRoute.settings.name;
      currentArguments = newRoute.settings is CustomRouteSettings
          ? (newRoute.settings as CustomRouteSettings).arguments
          : null;
    }

    if (oldRoute is PageRoute) {
      previousRouteName = oldRoute.settings.name;
      previousArguments = oldRoute.settings is CustomRouteSettings
          ? (oldRoute.settings as CustomRouteSettings).arguments
          : null;
    }
  }
}