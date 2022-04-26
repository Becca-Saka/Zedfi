import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zedfi/app/routes/app_pages.dart';
import 'package:zedfi/controller/authentication_controller.dart';
import 'package:zedfi/services/navigation_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationController(),
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Zedfi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
        ),
        initialRoute: AppPages.initialRoutes,
        onGenerateRoute: AppPages.onGenerateRoutes,
      ),
    );
  }
}
