import 'package:flutter/material.dart';
import 'package:zedfi/app/routes/app_routes.dart';
import 'package:zedfi/ui/views/authentication_view.dart';
import 'package:zedfi/ui/views/dashboard_view.dart';
import 'package:zedfi/ui/views/email_verification_view.dart';
import 'package:zedfi/ui/views/phone_verification_view.dart';

class AppPages {
  static String initialRoutes = AppRoutes.authentication;
  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.authentication:
        return MaterialPageRoute(
          builder: (context) => AuthenticationView(),
          settings: settings,
        );
      case AppRoutes.phoneVerify:
        return MaterialPageRoute(
          builder: (context) => PhoneVerificationView(),
          settings: settings,
        );
      case AppRoutes.emailVerify:
        return MaterialPageRoute(
          builder: (context) {
            final email = settings.arguments as String;
            return EmailVerificationView(
              email: email,
            );
          },
          settings: settings,
        );
      case AppRoutes.dashBoard:
        return MaterialPageRoute(
          builder: (context) => const DashboardView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Unknown Route',
                    ),
                    Text(
                      'No route was provided',
                    ),
                  ],
                )),
            settings: settings);
    }
  }
}
