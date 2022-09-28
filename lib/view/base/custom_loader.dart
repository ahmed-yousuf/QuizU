import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/view/base/loading.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      alignment: Alignment.center,
      child: const LoadingLottie(
        height: 300,
      ),
    ));
  }
}
