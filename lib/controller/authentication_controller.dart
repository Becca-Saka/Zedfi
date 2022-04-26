import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/app/routes/app_routes.dart';
import 'package:zedfi/services/firebase_auth_service.dart';
import 'package:zedfi/services/navigation_services.dart';
import 'package:zedfi/services/notification_service.dart';

class AuthenticationController extends ChangeNotifier {
  String? fieldInput;
  bool isPhoneNumber = false;
  TextInputType keyboardType = TextInputType.emailAddress;
  String? verificationID, smsCode;
  final FirebaseAuthService _authService = FirebaseAuthService();

  void onTextChanged(
    String? value,
    BuildContext context,
    FocusNode node,
  ) {
    fieldInput = value;
    if (value != null) {
      _detectFieldType(value, context, node);
    }
    notifyListeners();
  }

  _detectFieldType(String value, BuildContext context, FocusNode node) async {
    if (value.isNotEmpty) {
      final hasDialingCode = value.startsWith('+');
      final checkNumberRegex = RegExp(r'^[0-9]+$');
      if ((hasDialingCode || checkNumberRegex.hasMatch(value)) &&
          value.length >= 3) {
        isPhoneNumber = true;
        await _changeKeyboard(TextInputType.number, context, node);
      }
    } else {
      isPhoneNumber = false;
      if (value.isEmpty) {
        _changeKeyboard(TextInputType.emailAddress, context, node);
      }
    }
  }

  _changeKeyboard(
      TextInputType type, BuildContext context, FocusNode focusNode) async {
    if (keyboardType != type) {
      keyboardType = type;
      notifyListeners();
      FocusScope.of(context).requestFocus(FocusNode());
      await Future.delayed(const Duration(milliseconds: 100)).then(
        (value) => FocusScope.of(context).requestFocus(focusNode),
      );
    }
  }

  Future<void> handleVerification() async {
    if (fieldInput != null) {
      if (isPhoneNumber) {
        await handlePhoneAuth();
      } else {
        await _authService.handleEmailAuthentication(fieldInput!);
      }
    }
  }

  Future<void> handlePhoneAuth() {
    return _authService.handlePhoneVerification(
        phoneNumber: fieldInput!,
        verificationCompleted: _createUserWithPhoneCredentials,
        codeSent: (String code, [int? resendToken]) {
          verificationID = code;
    log('code verificationID 1 $code');
          NavigationService.navigateTo(AppRoutes.phoneVerify);
        },
        codeAutoRetrievalTimeout: (String code) {
          verificationID = code;
    log('code verificationID 2$code');
        });
  }

  Future<void> verifySmsCode(String code) async {
    log('code $code');
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID!,
      smsCode: code,
    );
    await _createUserWithPhoneCredentials(credential);
  }

  Future<void> _createUserWithPhoneCredentials(AuthCredential credential) =>
      _authService.createUserWithCredentials(credential);

  Future<void> getSmsCode(String code) {
    log('code $code');
    return verifySmsCode(code);
  }
}
