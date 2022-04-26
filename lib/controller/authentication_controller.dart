import 'package:flutter/material.dart';
import 'package:zedfi/services/firebase_auth_service.dart';

class AuthenticationController extends ChangeNotifier {
  String? fieldInput;
  bool isPhoneNumber = false;
  TextInputType keyboardType = TextInputType.emailAddress;

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

  handleVerification() {
    if (fieldInput != null) {
      if (isPhoneNumber) {
      } else {
        _authService.handleEmailAuthentication(fieldInput!);
      }
    }
  }
  
}
