import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:zedfi/controller/authentication_controller.dart';
import 'package:zedfi/ui/widgets/app_size.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Zedfi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.safeblockSizeHorizontal * 7.3,
                  ),
                ),
                Text(
                  'Your details is: ${controller.inputController.text}',
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
    });
  }
}
