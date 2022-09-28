import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/theme/dark_theme.dart';
import 'package:quizu/theme/light_theme.dart';
import 'package:quizu/util/app_constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'helper/get_di.dart' as di;
import 'controller/theme_controller.dart';

void main() async {
  runApp(const MyApp());
  await di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return OverlaySupport.global(
        child: GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: themeController.darkTheme ? dark : light,
          initialRoute: RouteHelper.splash,
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }
}
