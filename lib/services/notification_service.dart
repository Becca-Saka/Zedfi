import 'package:flutter/material.dart';
import 'package:zedfi/services/navigation_services.dart';

///Handles all alerts that are show to the user inside the app
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

///Shows a dialog for user to confirm their phone number is correct before sending code
  static showNumberVerificationDialog(
    String number, {
    bool isInvalid = false,
    Function()? sendCode,
  }) {
    if (navigatorKey.currentContext != null) {
      showDialog(
          context: navigatorKey.currentContext!,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                  isInvalid ? 'Invalid Phone number' : 'Confirm Phone number'),
              content: Text(isInvalid
                  ? '$number is not a valid number, please chack the number again'
                  : 'A code will be sent to $number, is this correct'),
              actions: isInvalid
                  ? [
                      const TextButton(
                        onPressed: back,
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ]
                  : [
                      const TextButton(
                        onPressed: back,
                        child: Text(
                          'cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          back();
                          if (sendCode != null) {
                            sendCode();
                          }
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
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
