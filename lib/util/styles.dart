// ignore_for_file: prefer_const_declarations
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:pinput/pinput.dart';

final poppinsRegular = const TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

final poppinsMedium = const TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

final poppinsBold = const TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

final poppinsBlack = const TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: Dimensions.FONT_SIZE_DEFAULT,
);

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 20, color: Color(0xFF8270F6), fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
    border: Border.all(
        color: Get.isDarkMode
            ? Colors.grey.withOpacity(0.2)
            : Colors.grey.withOpacity(0.2)),
    borderRadius: BorderRadius.circular(8),
  ),
);
final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(
    color: const Color(0xFF8270F6),
  ),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Get.isDarkMode
        ? Colors.grey[800]
        : const Color(0xFF8270F6).withOpacity(0.1),
  ),
);
