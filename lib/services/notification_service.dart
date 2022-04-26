import 'package:flutter/material.dart';
import 'package:zedfi/services/navigation_services.dart';

class NotificationService {
  static GlobalKey<NavigatorState> get navigatorKey =>
      NavigationService.navigatorKey;


  static showLoadingDialog(String message) {
    if (navigatorKey.currentContext != null) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(message),
                  ],
                ),
              ),
            );
          });
    }
  }

  static showSnackBar(String message) {
    if (navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  static back() => navigatorKey.currentState!.pop();
}
