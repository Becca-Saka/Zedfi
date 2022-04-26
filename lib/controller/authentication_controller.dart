import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/app/helpers/number_parser.dart';
import 'package:zedfi/app/routes/app_routes.dart';
import 'package:zedfi/services/firebase_auth_service.dart';
import 'package:zedfi/services/navigation_services.dart';
import 'package:zedfi/services/notification_service.dart';

class AuthenticationController extends ChangeNotifier {
  bool isPhoneNumber = false;
  Map<String, dynamic>? parsedNumber;
  TextInputType keyboardType = TextInputType.emailAddress;
  String? verificationID, smsCode;
  final FirebaseAuthService _authService = FirebaseAuthService();
  final NumberParser _numberParser = NumberParser();
  TextEditingController inputController = TextEditingController();
  String flagValue = 'GB';

  void onTextChanged(
    String? value,
    BuildContext context,
    FocusNode node,
  ) {
    if (value != null) {
      _detectFieldType(value, context, node);
    }
  }

//Checks the type of field and changes the keyboardType according to th field in the textfield
  _detectFieldType(String value, BuildContext context, FocusNode node) async {
    if (value.isNotEmpty) {
      final hasDialingCode = value.startsWith('+');
      final checkNumberRegex = RegExp(r'^[0-9]+$');
      value = value.replaceAll(' ', '');
      if ((hasDialingCode || checkNumberRegex.hasMatch(value)) &&
          value.length >= 3) {
        isPhoneNumber = true;
        await _changeKeyboard(TextInputType.number, context, node);
        _formatNumber();
      }
    } else {
      isPhoneNumber = false;
      if (value.isEmpty) {
        _changeKeyboard(TextInputType.emailAddress, context, node);
      }
    }

    notifyListeners();
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
    if (inputController.text.isNotEmpty) {
      if (isPhoneNumber) {
        await _verifyPhoneNumber();
      } else {
        await _authService.handleEmailAuthentication(inputController.text);
      }
    }
  }

  Future<void> _verifyPhoneNumber() async {
    if (parsedNumber == null) {
      NotificationService.showNumberVerificationDialog(
        inputController.text,
        isInvalid: true,
      );
    } else {
      NotificationService.showNumberVerificationDialog(
        inputController.text,
        sendCode: () async => await handlePhoneAuth(),
      );
    }
  }

  Future<void> handlePhoneAuth() {
    return _authService.handlePhoneVerification(
        phoneNumber: inputController.text,
        verificationCompleted: _createUserWithPhoneCredentials,
        codeSent: (String code, [int? resendToken]) {
          verificationID = code;
          NavigationService.navigateTo(AppRoutes.phoneVerify);
        },
        codeAutoRetrievalTimeout: (String code) {
          verificationID = code;
        });
  }

  Future<void> verifySmsCode(String code) async {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationID!,
      smsCode: code,
    );
    await _createUserWithPhoneCredentials(credential);
  }

  Future<void> _createUserWithPhoneCredentials(AuthCredential credential) =>
      _authService.createUserWithCredentials(credential);

  Future<void> getSmsCode(String code) => verifySmsCode(code);

  void _formatNumber() async {
    parsedNumber = null;
    final numberToFormat = inputController.text.replaceAll(' ', '');
    final result =
        await _numberParser.formatPhoneNumber(numberToFormat, flagValue);
    if (result != null) {
      parsedNumber = result;
      flagValue = result['regionCode'];
      final number = _numberParser.formatNumberforUserField(result);
      inputController.value = inputController.value.copyWith(
          text: number,
          selection: TextSelection.collapsed(offset: number.length));
    }
  }
}
