import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/custom_loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        bottom: true,
        top: false,
        child: GetBuilder<UserController>(builder: (userController) {
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
                                Text(
                                  'Welcome Back',
                                  style: poppinsRegular.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: Colors.white),
                                ),
                                Text(
                                  userController.userDataModel!.name ?? "",
                                  style: poppinsBold.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_LARGE + 5,
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
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
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
    );
  }
}
