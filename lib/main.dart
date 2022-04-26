import 'package:flutter/material.dart';
import 'package:zedfi/ui/views/authentication_view.dart';
import 'package:zedfi/ui/views/verification_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins'
      ),
      home:  VerificationView(),
    );
  }
}
