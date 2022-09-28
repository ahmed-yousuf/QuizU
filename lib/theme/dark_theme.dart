import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: const Color(0xFFFF6DAA),
  secondaryHeaderColor: const Color(0xFFFF6DAA),
  disabledColor: const Color(0xffa2a7ad),
  backgroundColor: const Color(0xFF343636),
  errorColor: const Color(0xFFdd3135),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  colorScheme: const ColorScheme.dark(
      primary: Color(0xFFED068F), secondary: Color(0xFFED068F)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: const Color(0xFFED068F))),
);
