import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../util/images.dart';

class LoadingLottie extends StatelessWidget {
  final double height;
  const LoadingLottie({Key? key, this.height = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Images.loading,
      height: height,
    );
  }
}
