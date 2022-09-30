// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/confirmation_dialog.dart';
import 'package:quizu/view/base/custom_loader.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late bool _allow;

  DateTime now = new DateTime.now();
  String timeWellcome(int hour) {
    if (1 <= hour && hour < 12 || 24 == hour) {
      return "Good Morning";
    } else if (12 <= hour && hour < 18) {
      return "Good Afternoon";
    } else if (17 < hour && hour < 24) {
      return "Good Evening";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.dialog(
            ConfirmationDialog(
                icon:
                    Lottie.asset(Images.warningDelete, height: 120, width: 120),
                description: 'Are you sure to Exit from QuizU App?',
                isLogOut: true,
                onNoPressed: () => _allow = true,
                onYesPressed: () {
                  // return _allow = false;
                  exit(0);
                  // Get.find<AuthController>()
                  //     .logout();
                  // Get.offAllNamed(RouteHelper
                  //     .getSignInRoute('Login'));
                }),
            useSafeArea: false);
        return Future.value(_allow);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: SafeArea(
          bottom: true,
          top: false,
          child: GetBuilder<UserController>(builder: (userController) {
            final welcome = timeWellcome(now.hour);
            return !userController.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: Get.height * 0.35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            image: const DecorationImage(
                                image: AssetImage(
                                  Images.homeBg,
                                ),
                                fit: BoxFit.cover)),
                        child: Stack(children: [
                          Positioned(
                              left: 20,
                              top: Get.height * 0.1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Time
                                  Text(
                                    '$welcome,',
                                    style: poppinsMedium.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    userController.userDataModel!.name
                                        .toString(),
                                    style: poppinsBold.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_LARGE +
                                                5,
                                        color: Colors.white),
                                  ),
                                ],
                              ))
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.topCenter,
                        height: Get.height * 0.25,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            Images.homeCard,
                          ),
                          fit: BoxFit.contain,
                        )),
                        child: Stack(children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Ready to test your knowledge and\nchallenge others?',
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                ),
                                Text(
                                  'Answer as much questions\ncorrectly within 2 minutes',
                                  style: poppinsBold.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_LARGE,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InkWell(
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 120,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(3, 3),
                                          blurRadius: 8,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.RADIUS_DEFAULT),
                                      ),
                                    ),
                                    child: Text(
                                      'Quiz Me!',
                                      style: poppinsBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                    ),
                                  ),
                                  onTap: () {
                                    //ToDO: Here Will Start The game!
                                    Get.toNamed(RouteHelper.getQuizRoute());
                                    Get.find<QuizController>().attemptsUser();
                                  },
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ],
                  )
                : CustomLoader(
                    bgColor: Theme.of(context).cardColor,
                  );
          }),
        ),
      ),
    );
  }
}
