// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/view/base/loading.dart';

class CustomLoader extends StatelessWidget {
  final Color bgColor;
  const CustomLoader({this.bgColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          color: bgColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      alignment: Alignment.center,
      child: const LoadingLottie(
        height: 300,
      ),
    ));
  }
}
