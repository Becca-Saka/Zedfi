import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:zedfi/ui/widgets/app_size.dart';

class EmailVerificationView extends StatelessWidget {
  final String email;
  EmailVerificationView({Key? key, required this.email}) : super(key: key);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23).copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We’ve sent you a link',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.safeblockSizeHorizontal * 7.3,
                ),
              ),
              Text(
                'Check your email at $email',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: AppSize.safeblockSizeHorizontal * 4.3,
                ),
              ),
              const Spacer(),
              Center(
                child: Icon(
                  IconlyBold.message,
                  size: AppSize.blockSizedVertical * 25,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
