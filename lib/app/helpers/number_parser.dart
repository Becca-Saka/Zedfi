import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

enum NumberParseType {
  national,
  nationalWithoutZero,
  international,
  internationalWithPlus,
}

class NumberParser {
  final FlutterLibphonenumber _libphonenumber = FlutterLibphonenumber();
  final CountryManager _countryManager = CountryManager();

  Future<Map<String, dynamic>?> formatPhoneNumber(
      String number, String regionCode) async {
    try {
      _libphonenumber.init();
      Map<String, dynamic> parsedNumber;
      if (number.startsWith('+')) {
        parsedNumber = await _libphonenumber.parse(number);
      } else {
        parsedNumber = await _libphonenumber.parse(number, region: regionCode);
      }
      
      final country = _countryManager.countries.where(
        (element) => element.phoneCode == parsedNumber['country_code'],
      );
      if (country.isNotEmpty) {
        parsedNumber['regionCode'] = country.first.countryCode;
        parsedNumber = _getNumberType(parsedNumber, number);
      }
      log('$parsedNumber');
      return parsedNumber;
    } on PlatformException catch (e) {
      log('invalid number ${e.message}');
      // TODO
    }
    return null;
  }

  ///Gets how the number is inputed into field so it can be formated accordingly without affecting user input
  Map<String, dynamic> _getNumberType(
    Map<String, dynamic> parsedNumber,
    String number,
  ) {
    final formatedWithoutSign = parsedNumber['e164'].replaceFirst('+', '');
    final formatedWithoutZero = parsedNumber['national_number'];
    final removeSpacing = parsedNumber['national'].replaceAll(' ', '');

    if (formatedWithoutSign == number) {
      parsedNumber['parseType'] = NumberParseType.international;
    } else if (formatedWithoutZero == number) {
      parsedNumber['parseType'] = NumberParseType.nationalWithoutZero;
    } else if (removeSpacing == number) {
      parsedNumber['parseType'] = NumberParseType.national;
    } else {
      parsedNumber['parseType'] = NumberParseType.internationalWithPlus;
    }
    return parsedNumber;
  }

  ///Formats the user field with appropriate  number "mask"
  String formatNumberforUserField(
    Map<String, dynamic> parsedNumber,
  ) {
    if (parsedNumber['parseType'] == NumberParseType.international) {
      return parsedNumber['international'].replaceFirst('+', '');
    } else if (parsedNumber['parseType'] ==
        NumberParseType.internationalWithPlus) {
      return parsedNumber['international'];
    } else if (parsedNumber['parseType'] == NumberParseType.national) {
      return parsedNumber['national'];
    } else {
      return parsedNumber['national_number'];
    }
  }
}
