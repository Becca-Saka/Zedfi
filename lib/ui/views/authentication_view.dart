import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:zedfi/controller/authentication_controller.dart';
import 'package:zedfi/ui/widgets/app_colors.dart';
import 'package:zedfi/ui/widgets/app_inputs.dart';
import 'package:zedfi/ui/widgets/app_size.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({Key? key}) : super(key: key);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Consumer<AuthenticationController>(
        builder: (context, controller, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23).copyWith(top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(IconlyLight.arrow_left),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Connect your wallet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.safeblockSizeHorizontal * 7.5,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: Text(
                    controller.isPhoneNumber
                        ? 'We’ll need this to verify your identity'
                        : 'We’ll send you a confirmation code',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSize.safeblockSizeHorizontal * 4.25,
                    ),
                  ),
                ),
                const Spacer(),
                AppInput(
                  focusNode: focusNode,
                  controller: controller.inputController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  keyboardType: controller.keyboardType,
                  labelText: controller.isPhoneNumber
                      ? 'Phone'
                      : 'Phone number or Email',
                  onChanged: (value) => controller.onTextChanged(
                    value,
                    context,
                    focusNode,
                  ),
                  prefix: focusNode.hasFocus
                      ? Flag.fromString(
                          controller.flagValue,
                          height: 12,
                          width: 40,
                        )
                      : null,
                  prefixIcon: !focusNode.hasFocus
                      ? Flag.fromString(
                          controller.flagValue,
                          height: 12,
                          width: 40,
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 12,
                    maxWidth: 40,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 51,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: controller.handleVerification,
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Visibility(
                  visible: !controller.isPhoneNumber,
                  replacement: RichText(
                    text: TextSpan(
                        text: 'By signing up I agree to Zëdfi’s ',
                        style: TextStyle(
                          fontSize: AppSize.blockSizeHorizontal * 3.3,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Privacy Policy ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                  ),
                  child: RichText(
                    text: TextSpan(
                        text: 'By signing up I agree to Zëdfi’s ',
                        style: TextStyle(
                          fontSize: AppSize.blockSizeHorizontal * 3.4,
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(
                            text: 'Privacy Policy ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                              text:
                                  ' and allow Zedfi to use your information for future '),
                          TextSpan(
                            text: 'Marketing purposes.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
