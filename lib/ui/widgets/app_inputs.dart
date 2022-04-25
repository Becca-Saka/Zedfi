
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/ui/widgets/app_colors.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.appGrey)),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 13),
          labelText: 'Phone number or Email',
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          prefix: focusNode.hasFocus
              ? const Flag.fromString(
                  'GB',
                  height: 12,
                  width: 40,
                )
              : null,
          prefixIcon: !focusNode.hasFocus
              ? const Flag.fromString(
                  'GB',
                  height: 12,
                  width: 40,
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 12,
            maxWidth: 40,
          ),
        ),
      ),
    );
  }
}
