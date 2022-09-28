import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/onboarding_controller.dart';
import 'package:quizu/controller/splash_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<OnBoardingController>().getOnBoardingList();

    return Scaffold(
      body: GetBuilder<OnBoardingController>(
        builder: (onBoardingController) => onBoardingController
                .onBoardingList.isNotEmpty
            ? SafeArea(
                child: Center(
                    child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(children: [
                          Expanded(
                              child: PageView.builder(
                            itemCount:
                                onBoardingController.onBoardingList.length,
                            controller: _pageController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(context.height * 0.05),
                                      child: Image.asset(
                                          onBoardingController
                                              .onBoardingList[index].imageUrl,
                                          height: context.height * 0.4),
                                    ),
                                    Text(
                                      onBoardingController
                                          .onBoardingList[index].title,
                                      style: poppinsMedium.copyWith(
                                          fontSize: context.height * 0.025),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: context.height * 0.025),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_LARGE),
                                      child: Text(
                                        onBoardingController
                                            .onBoardingList[index].description,
                                        style: poppinsRegular.copyWith(
                                            fontSize: context.height * 0.020,
                                            color: Theme.of(context)
                                                .disabledColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]);
                            },
                            onPageChanged: (index) {
                              onBoardingController.changeSelectIndex(index);
                            },
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                _pageIndicators(onBoardingController, context),
                          ),
                          SizedBox(height: context.height * 0.05),
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_SMALL),
                            child: Row(children: [
                              onBoardingController.selectedIndex == 2
                                  ? const SizedBox()
                                  : Expanded(
                                      child: CustomButton(
                                        transparent: true,
                                        onPressed: () {
                                          Get.find<SplashController>()
                                              .setShowIntro(false);
                                          Get.offNamed(
                                              RouteHelper.getSignInRoute(
                                                  RouteHelper.onBoarding));
                                        },
                                        buttonText: 'Skip',
                                        // textColor: Colors.white,
                                      ),
                                    ),
                              Expanded(
                                child: CustomButton(
                                  textColor: Colors.white,
                                  radius: 8,
                                  buttonText:
                                      onBoardingController.selectedIndex != 2
                                          ? 'Next'
                                          : 'Get Started',
                                  onPressed: () {
                                    if (onBoardingController.selectedIndex !=
                                        2) {
                                      _pageController.nextPage(
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.ease);
                                    } else {
                                      Get.find<SplashController>()
                                          .setShowIntro(false);
                                      Get.offNamed(RouteHelper.getSignInRoute(
                                          RouteHelper.onBoarding));
                                    }
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ]))),
              )
            : const SizedBox(),
      ),
    );
  }

  List<Widget> _pageIndicators(
      OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingController.onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: 7,
          height: 7,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(8)
                : BorderRadius.circular(8),
          ),
        ),
      );
    }
    return _indicators;
  }
}
