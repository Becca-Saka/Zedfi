import 'package:flutter/material.dart';

/// Divides devices screen into pixels to enable widget scale accounding to screen size
class AppSize {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double blockSizeHorizontal;
  static late double blockSizedVertical;
  static late double safeblockSizeHorizontal;
  static late double safeblockSizedVertical;
  static late double _safeAreaVertical;
  static late double _safeAreaHorizontal;
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    blockSizeHorizontal = width / 100;
    blockSizedVertical = height / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeblockSizeHorizontal = (width - _safeAreaHorizontal) / 100;
    safeblockSizedVertical = (height - _safeAreaVertical) / 100;
  }
}
