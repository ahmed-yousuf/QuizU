import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/controller/leader_controller.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/splash_controller.dart';
import 'package:quizu/controller/theme_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/app_constants.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/Screen/home/bottom_nav.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:quizu/view/base/custom_snackbar.dart';
import 'package:quizu/view/base/custom_text_field.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  final FocusNode _firstNameFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });
    // Get.find<AuthController>().verfiyToken();

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Timer(const Duration(seconds: 3), () async {
      if (Get.find<SplashController>().getShowIntro()) {
        Get.offNamed(RouteHelper.getOnBoardingRoute());
        Get.find<SplashController>().setShowIntro(false);
      } else if (Get.find<AuthController>().getMyToken() != '') {
        Get.find<AuthController>().verfiyToken().then((value) {
          if (value.success ?? false) {
            // print(value.success);
            Get.find<LeaderController>().topUserData();
            Get.find<QuizController>().getQuiz();
            Get.find<UserController>().userData();
            Get.find<ThemeController>().loadCurrentTheme();

            if (Get.find<AuthController>().getSaveName().contains('null')) {
              Get.bottomSheet(
                Container(
                    height: Get.height * 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Colors.grey[850]
                            : Colors.grey[200],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Please Enter your name:',
                          style: poppinsRegular.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          isNote: true,
                          hintText: 'Name',
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          divider: true,
                        ),
                        GetBuilder<AuthController>(builder: (authController) {
                          return CustomButton(
                              buttonText: 'Save Name',
                              transparent: true,
                              buttonColor: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                if (_firstNameController.text.isNotEmpty) {
                                  // print(_firstNameController.text);
                                  authController
                                      .updateName(_firstNameController.text)
                                      .then((value) {
                                    if (value.success ?? false) {
                                      _firstNameController.clear();
                                      // print(value.message.toString());
                                      Get.find<AuthController>()
                                          .setUserName(value.name.toString());
                                      showCustomSnackBar(
                                          value.message.toString(), context,
                                          isError: false);
                                      Get.offNamed(
                                          RouteHelper.getInitialRoute(),
                                          arguments:
                                              BottomBar(selectedIndex: 0));
                                    } else {
                                      showCustomSnackBar(
                                          'Please Enter your name!!', context,
                                          isError: true);
                                      // Get.offNamed(RouteHelper.getInitialRoute());
                                    }
                                  });
                                } else {
                                  showCustomSnackBar(
                                      'Please Enter your name!!', context,
                                      isError: true);
                                }
                              });
                        })
                      ],
                    )),

                barrierColor: Colors.black.withOpacity(0.5),
                isDismissible: false,

                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(35),
                // ),
                enableDrag: true,
              );
            } else {
              Get.find<LeaderController>().topUserData();
              Get.offNamed(RouteHelper.getInitialRoute(),
                  arguments: BottomBar(selectedIndex: 0));
            }
          } else {
            Get.offNamed(RouteHelper.getSignInRoute('s'));
          }
        });
      } else {
        Get.offNamed(RouteHelper.getSignInRoute('s'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image.asset(Images.logoName, width: 300),
                  // Spacer(),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Developed By " + AppConstants.DEVELOPER_NAME,
                  style: poppinsMedium.copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
