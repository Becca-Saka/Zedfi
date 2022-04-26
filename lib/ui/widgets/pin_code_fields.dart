import 'package:flutter/material.dart';
import 'package:zedfi/ui/widgets/app_inputs.dart';
import 'package:zedfi/ui/widgets/app_size.dart';

class PinCodeFields extends StatefulWidget {
  final Function(String) onPinSubmitted;
  const PinCodeFields({Key? key, required this.onPinSubmitted})
      : super(key: key);

  @override
  State<PinCodeFields> createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  final FocusNode box1 = FocusNode();
  final FocusNode box2 = FocusNode();
  final FocusNode box3 = FocusNode();
  final FocusNode box4 = FocusNode();
  final FocusNode box5 = FocusNode();
  final FocusNode box6 = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? text1, text2, text3, text4, text5, text6;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppInput(
            focusNode: box1,
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (val) {
              text1 = val;
              if (val.isEmpty) {
              } else {
                box1.unfocus();
                FocusScope.of(context).requestFocus(box2);
              }
            },
          ),
          AppInput(
            focusNode: box2,
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (val) {
              text2 = val;
              if (val.isEmpty) {
                box2.unfocus();
                FocusScope.of(context).requestFocus(box1);
              } else {
                box2.unfocus();
                FocusScope.of(context).requestFocus(box3);
              }
            },
          ),
          AppInput(
            focusNode: box3,
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (val) {
              text3 = val;
              if (val.isEmpty) {
                box3.unfocus();
                FocusScope.of(context).requestFocus(box2);
              } else {
                box3.unfocus();
                FocusScope.of(context).requestFocus(box4);
              }
            },
          ),
          AppInput(
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            focusNode: box4,
            onChanged: (val) {
              text4 = val;
              if (val.isEmpty) {
                box4.unfocus();
                FocusScope.of(context).requestFocus(box3);
              } else {
                box4.unfocus();
                FocusScope.of(context).requestFocus(box5);
              }
            },
          ),
          AppInput(
            focusNode: box5,
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (val) {
              text5 = val;
              if (val.isEmpty) {
                box5.unfocus();
                FocusScope.of(context).requestFocus(box4);
              } else {
                box5.unfocus();
                FocusScope.of(context).requestFocus(box6);
              }
            },
          ),
          AppInput(
            focusNode: box6,
            height: AppSize.blockSizedVertical * 8,
            width: AppSize.blockSizeHorizontal * 13,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (val) {
              text6 = val;
              if (val.isEmpty) {
                box6.unfocus();
                FocusScope.of(context).requestFocus(box5);
              } else {
                if (_formKey.currentState!.validate()) {
                  final pin = '$text1$text2$text3$text4$text5$text6';
                  widget.onPinSubmitted(pin);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
