import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zedfi/ui/widgets/app_colors.dart';

///Create a customizable user input from [TextFormField]
class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final String? labelText;
  final bool obscureText;
  final Function(String)? onChanged;
  final TextAlign textAlign;
  final double? height, width;
  final int? maxLength;
  final TextInputType? keyboardType;
  const AppInput({
    Key? key,
    this.focusNode,
    this.prefix,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.labelText,
    this.obscureText = true,
    this.onChanged,
    this.textAlign = TextAlign.center,
    this.height,
    this.width,
    this.maxLength,
    this.keyboardType, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.appGrey)),
      child: Center(
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textAlign: textAlign,
          obscuringCharacter: '•',
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          onChanged: onChanged,
          maxLength: maxLength,
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            labelText: labelText,
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            prefix: prefix,
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
          ),
        ),
      ),
    );
  }
}
