// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/leader_controller.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/custom_loader.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8270F6),
      body: GetBuilder<LeaderController>(builder: (lController) {
        return SizedBox(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Get.isDarkMode
                        ? Images.leaderboardBgDark
                        : Images.leaderboardBg,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: !lController.isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Stack(
                            children: [
                              Container(
                                height: Get.height * 0.4,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      Images.leaderboardTop,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: Get.height * 0.008,
                                left: 0,
                                top: Get.height * 0.055,
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Text(
                                    lController.topUserList![0].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                      color: Colors.amber,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: Get.height * 0.008,
                                left: 0,
                                top: Get.height * 0.170,
                                child: Text(
                                  lController.topUserList![0].score.toString(),
                                  textAlign: TextAlign.center,
                                  style: poppinsMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: Get.height * 0.050,
                                top: Get.height * 0.125,
                                child: SizedBox(
                                  height: 20,
                                  width: 110,
                                  child: Text(
                                    lController.topUserList![1].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: Get.height * 0.080,
                                top: Get.height * 0.230,
                                child: SizedBox(
                                  height: 20,
                                  width: 65,
                                  child: Text(
                                    lController.topUserList![1].score
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: Get.height * 0.060,
                                top: Get.height * 0.155,
                                child: SizedBox(
                                  height: 20,
                                  width: 110,
                                  child: Text(
                                    lController.topUserList![2].name.toString(),
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                      color: Colors.white,
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: Get.height * 0.090,
                                top: Get.height * 0.260,
                                child: SizedBox(
                                  height: 20,
                                  width: 70,
                                  child: Text(
                                    lController.topUserList![2].score
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: poppinsMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                                itemCount: lController.topUserList!.length - 3,
                                separatorBuilder: (__, _) =>
                                    const SizedBox(height: 5),
                                itemBuilder: (context, index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFF8270F6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  Dimensions.RADIUS_DEFAULT)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xFF0F0D2388),
                                                offset: Offset(10, 24),
                                                blurRadius: 54)
                                          ]),
                                      child: ListTile(
                                        leading: Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.all(8),
                                          height: 70,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF6F5DE5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          child: Text(
                                            '${index + 4}',
                                            style: poppinsBold.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE,
                                                color: Colors.white),
                                          ),
                                        ),
                                        title: Text(
                                          lController
                                              .topUserList![index + 3].name
                                              .toString(),
                                          style: poppinsBold.copyWith(
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_LARGE,
                                              color: Colors.white),
                                        ),
                                        trailing: Text(
                                          lController
                                              .topUserList![index + 3].score
                                              .toString(),
                                          style: poppinsBold.copyWith(
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_LARGE,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                          )
                        ])
                  : const CustomLoader()),
        );
      }),
    );
  }
}
