// ignore_for_file: unused_field, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/controller/leader_controller.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/Screen/home/bottom_nav.dart';
import 'package:quizu/view/base/custom_app_bar.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:quizu/view/base/custom_snackbar.dart';
import 'package:quizu/view/base/custom_text_field.dart';
import 'package:quizu/view/base/loading.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  final String? number;

  VerificationScreen({required this.number});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int isClickedOtp = 0;
  int isClickedName = 0;

  final FocusNode _firstNameFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();

  late String _number;
  late String _numberWithoutCode;

  late Timer _timer;
  int _seconds = 0;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _numberWithoutCode = widget.number!;
    _number = (widget.number!.startsWith('+')
        ? widget.number
        : '+' + widget.number!.substring(1, widget.number!.length))!;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _firstNameFocus.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'OTP Verification'),
      body: SafeArea(
          child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: const LoadingLottie(
                height: 180,
              ),
            ),
            Center(
                child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              decoration: BoxDecoration(
                // color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
              child: GetBuilder<AuthController>(builder: (authController) {
                return Column(children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Enter the verification sent to',
                        style: poppinsRegular.copyWith(
                            color: Theme.of(context).disabledColor)),
                    TextSpan(
                        text: ' $_number',
                        style: poppinsMedium.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                  ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                          length: 4,
                          autofocus: true,
                          // controller: otpController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          showCursor: true,
                          onChanged: authController.updateVerificationCode),
                    ),
                  ),
                  authController.verificationCode.length == 4
                      ? CustomButton(
                          buttonText: authController.isLoadingLogin
                              ? 'Verify Again'
                              : 'Verify',
                          textColor: Colors.white,
                          onPressed: () async {
                            print("isClicked Otp -------->" +
                                isClickedOtp.toString());
                            isClickedOtp++;
                            if (isClickedOtp < 2) {
                              // print('sfjkbvdkfjbvdsfkljbvldf----------');
                              print("User Verfiy Login -------->" + _number);
                              print("isClicked Otp -------->" +
                                  isClickedOtp.toString());

                              authController
                                  .login(
                                      _number, authController.verificationCode)
                                  .then((value) {
                                if (value.success ?? false) {
                                  Get.find<AuthController>()
                                      .setSaveToken(value.token.toString());
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    Get.find<LeaderController>().topUserData();
                                    Get.find<QuizController>().getQuiz();
                                    Get.find<UserController>().userData();
                                  });

                                  print("User Token+Vrefiy-------> " +
                                      value.token.toString());
                                  // print(
                                  //     "skjdgckjdk ----" + value.name.toString());
                                  // authController
                                  //     .setUserName(value.name.toString());
                                  // authController
                                  //     .setUserNumber(value.mobile.toString());
                                  bool checkNull = value.userStatus == null
                                      ? false
                                      : value.userStatus!.contains('new');

                                  if (value.name == null || checkNull) {
                                    // setState(() {
                                    //   isClickedName = 0;
                                    // });
                                    Get.bottomSheet(
                                      Container(
                                          height: Get.height * 2,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? Colors.grey[850]
                                                  : Colors.grey[200],
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          padding: const EdgeInsets.all(
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_LARGE),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Please Enter your name:',
                                                style: poppinsRegular.copyWith(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              CustomTextField(
                                                isNote: true,
                                                hintText: 'Name',
                                                controller:
                                                    _firstNameController,
                                                focusNode: _firstNameFocus,
                                                inputType: TextInputType.name,
                                                capitalization:
                                                    TextCapitalization.words,
                                                divider: true,
                                              ),
                                              GetBuilder<AuthController>(
                                                  builder: (authController) {
                                                return CustomButton(
                                                    buttonText: 'Save Name',
                                                    transparent: true,
                                                    buttonColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      if (_firstNameController
                                                          .text.isNotEmpty) {
                                                        setState(() {
                                                          isClickedName++;
                                                        });
                                                        print(
                                                            "isClicked!!!Name" +
                                                                isClickedName
                                                                    .toString());
                                                        if (isClickedName < 2) {
                                                          print(
                                                              _firstNameController
                                                                  .text);

                                                          authController
                                                              .updateName(
                                                                  _firstNameController
                                                                      .text)
                                                              .then((value) {
                                                            if (value.success ??
                                                                false) {
                                                              authController
                                                                  .setUserName(value
                                                                      .name
                                                                      .toString());
                                                              // print(value.message
                                                              //     .toString());
                                                              Get.find<
                                                                      UserController>()
                                                                  .userData();
                                                              showCustomSnackBar(
                                                                  value.message
                                                                      .toString(),
                                                                  context,
                                                                  isError:
                                                                      false);
                                                              Get.offAllNamed(
                                                                  RouteHelper
                                                                      .getInitialRoute(),
                                                                  arguments:
                                                                      BottomBar(
                                                                          selectedIndex:
                                                                              0));
                                                            } else {
                                                              setState(() {
                                                                isClickedName =
                                                                    0;
                                                              });
                                                              showCustomSnackBar(
                                                                  'Please Enter your name!',
                                                                  context,
                                                                  isError:
                                                                      true);
                                                              // Get.offNamed(RouteHelper.getInitialRoute());
                                                            }
                                                          });
                                                        }
                                                      } else {
                                                        setState(() {
                                                          isClickedName = 0;
                                                        });
                                                        print(
                                                            "isClicked!!!Name" +
                                                                isClickedName
                                                                    .toString());
                                                        showCustomSnackBar(
                                                            'Please Enter your name!!',
                                                            context,
                                                            isError: true);
                                                      }
                                                    });
                                              })
                                            ],
                                          )),

                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      isDismissible: false,

                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(35),
                                      // ),
                                      enableDrag: true,
                                    );
                                  } else if (value.name != null) {
                                    Get.find<UserController>().userData();
                                    Get.offAllNamed(
                                        RouteHelper.getInitialRoute(),
                                        arguments: BottomBar(selectedIndex: 0));
                                  }
                                } else {
                                  setState(() {
                                    isClickedOtp = 0;
                                  });
                                  print(
                                      "isClicked!!!" + isClickedOtp.toString());
                                  showCustomSnackBar(
                                    'Your OTP is invalid',
                                    context,
                                  );
                                }
                              });
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ]);
              }),
            )),
          ],
        ),
      )))),
    );
  }
}
