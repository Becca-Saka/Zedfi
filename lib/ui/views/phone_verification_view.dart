import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zedfi/controller/authentication_controller.dart';
import 'package:zedfi/ui/widgets/app_size.dart';
import 'package:zedfi/ui/widgets/pin_code_fields.dart';

class PhoneVerificationView extends StatelessWidget {
  PhoneVerificationView({Key? key}) : super(key: key);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Consumer<AuthenticationController>(
        builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23).copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We’ve sent you a code',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.safeblockSizeHorizontal * 7.3,
                    ),
                  ),
                  Text(
                    'Enter the confirmation code below ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSize.safeblockSizeHorizontal * 4.25,
                    ),
                  ),
                  const Spacer(),
                  PinCodeFields(
                    onPinSubmitted: controller.getSmsCode,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Didn’t recieve a code? ',
                        style: TextStyle(
                          fontSize: AppSize.blockSizeHorizontal * 3.3,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Wait for 57 sec',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
