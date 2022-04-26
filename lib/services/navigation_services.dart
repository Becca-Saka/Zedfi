import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static navigateTo(
    String name, {
    Object? arguments,
  }) {
    Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
      name,
      arguments: arguments,
    );
  }

  static void back() => navigatorKey.currentState!.pop();
}
