// ignore_for_file: prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizu/util/app_constants.dart';

class ThemeController extends GetxController {
  GetStorage _theme = GetStorage();
  GetStorage get saveTheme => _theme;

  bool _darkTheme =
      SchedulerBinding.instance?.window.platformBrightness == Brightness.dark;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _theme.write(AppConstants.THEME, _darkTheme);
    update();
  }

  void loadCurrentTheme() async {
    _darkTheme = _theme.read(AppConstants.THEME) ?? false;
    update();
  }

  @override
  void onInit() {
    loadCurrentTheme();
    super.onInit();
  }
}
