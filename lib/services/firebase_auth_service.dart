import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:zedfi/app/routes/app_routes.dart';
import 'package:zedfi/services/navigation_services.dart';
import 'package:zedfi/services/notification_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String password =
      '1234567'; //Hardcoded password since we are not requestion password from user

  Future<void> handleEmailAuthentication(String email) async {
    try {
      NotificationService.showSnackBar('error');
      NotificationService.showLoadingDialog('Loading...');
      final signinMethods = await _auth.fetchSignInMethodsForEmail(email);
      User? user;
      if (signinMethods.isNotEmpty) {
        user = await _signInWithEmail(email);
      } else {
        user = await _createUserInWithEmail(email);
      }
      await _handleEmailUserAuthenticated(user);
    } on FirebaseAuthException catch (e) {
      NavigationService.back();
      final error = getErrorMessageFromCode(e.message);
      NotificationService.showSnackBar(error);
    } catch (e) {
      NavigationService.back();
      final error = getErrorMessageFromCode(e.toString());
      NotificationService.showSnackBar(error);
    }
  }

  Future<void> _handleEmailUserAuthenticated(User? user) async {
    if (user != null) {
      if (!user.emailVerified) {
        await _sendEmailVerification(user);
        NavigationService.navigateTo(AppRoutes.emailVerify,
            arguments: '${user.email}');
        await _listenForEmailVerification();
      } else {
        NavigationService.navigateTo(AppRoutes.dashBoard);
      }
    }
  }

  Future<User?> _createUserInWithEmail(String email) async {
    return (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
  }

  Future<User?> _signInWithEmail(String email) async {
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
  }

  Future<void> _sendEmailVerification(User user) =>
      user.sendEmailVerification();

  Future<void> _listenForEmailVerification() async {
    bool isVerified = false;
    while (!isVerified) {
      await Future.delayed(const Duration(seconds: 2));
      isVerified = await userVerified;
      if (isVerified) {
        NavigationService.navigateTo(AppRoutes.dashBoard);
      }
    }
  }

  Future<bool> get userVerified async {
    if (_auth.currentUser != null) {
      _auth.currentUser!.reload();
      return _auth.currentUser!.emailVerified;
    }

    return false;
  }

  Future<void> handlePhoneVerification({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  }) {
    NotificationService.showLoadingDialog('Loading...');
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: (FirebaseAuthException exception) {
        NotificationService.back();
        final message = getErrorMessageFromCode(exception.message);
        NotificationService.showSnackBar(message);
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> createUserWithCredentials(AuthCredential credential) async {
    try {
      NotificationService.showLoadingDialog('Verifying code...');
      final user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        NavigationService.navigateTo(AppRoutes.dashBoard);
      }
    } on FirebaseAuthException catch (e) {
      NavigationService.back();
      log('${e.code}');
      final messageCode = e.code;
      final error = getErrorMessageFromCode(e.code);
      NotificationService.showSnackBar(error);
      if (messageCode == 'session-expired') {
        NavigationService.back();
      }
    } catch (e) {
      NavigationService.back();
      final error = getErrorMessageFromCode(e.toString());
      NotificationService.showSnackBar(error);
    }
  }

  String getErrorMessageFromCode(String? message) {
    switch (message) {
      case 'wrong-password':
        return 'Invalid password';
      case 'too-many-requests':
        return 'Too many requests, please wait and try again';
      case 'session-expired':
        return 'Session Expired, starting auth process again';
      case 'invalid-phone-number':
        return 'Phone number is not correct, please check the number';
      case 'invalid-verification-code':
        return 'Pin not correct, try again';
      default:
        return 'Something went Wrong, Please try again';
    }
  }
}
