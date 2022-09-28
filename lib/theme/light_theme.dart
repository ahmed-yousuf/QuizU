import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFF8270F6),
  secondaryHeaderColor: const Color(0xFFFF6DAA),
  disabledColor: const Color(0xFFBABFC4),
  // backgroundColor: const Color(0xFFF3F3F3),
  backgroundColor: const Color(0xFF8270F6),
  errorColor: const Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: Color(0xFF8270F6), secondary: Color(0xFF8270F6)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: const Color(0xFF8270F6))),
);
