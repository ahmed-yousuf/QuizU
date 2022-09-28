// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/controller/leader_controller.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/theme_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/base/confirmation_dialog.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:quizu/view/base/custom_snackbar.dart';
import 'package:quizu/view/base/custom_text_field.dart';
import 'package:quizu/view/base/loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  int isClicked = 0;

  final TextEditingController _firstNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<QuizController>(builder: (quizController) {
        return GetBuilder<UserController>(builder: (userController) {
          return GetBuilder<LeaderController>(builder: (lController) {
            return Container(
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
              child: !userController.isLoading
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: Get.height * 0.75,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              children: [
                                GetBuilder<UserController>(
                                    builder: (userController) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height:
                                            Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                      ),
                                      Text(
                                        userController.userDataModel!.name
                                            .toString(),
                                        style: poppinsBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE +
                                                  3,
                                        ),
                                      ),
                                      Text(
                                        userController.userDataModel!.mobile
                                            .toString(),
                                        style: poppinsBold.copyWith(
                                          color: Colors.grey,
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: Get.height * 0.15,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Images.profileIcon1,
                                              height: 30,
                                            ),
                                            Text(
                                              quizController
                                                  .getHighUserScore()
                                                  .toString(),
                                              style: poppinsBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Max Points',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 80,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Images.profileIcon2,
                                              height: 30,
                                            ),
                                            Text(
                                              quizController.records.length
                                                  .toString(),
                                              style: poppinsBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Wins',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 80,
                                        color: Colors.white,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Images.profileIcon3,
                                              height: 30,
                                            ),
                                            Text(
                                              quizController.attempts
                                                  .toString(),
                                              style: poppinsBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Attempts',
                                              style: poppinsRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: Cros,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF8270F6),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Image.asset(
                                          Images.profileEdit,
                                          scale: 3,
                                          color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isClicked++;
                                        });
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
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              padding: const EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_EXTRA_LARGE),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'To update please enter your name:',
                                                    style:
                                                        poppinsRegular.copyWith(
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
                                                    inputType:
                                                        TextInputType.name,
                                                    capitalization:
                                                        TextCapitalization
                                                            .words,
                                                    divider: true,
                                                  ),
                                                  GetBuilder<AuthController>(
                                                      builder:
                                                          (authController) {
                                                    return CustomButton(
                                                        buttonText:
                                                            'Update Name',
                                                        transparent: true,
                                                        buttonColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        textColor: Colors.white,
                                                        onPressed: () async {
                                                          if (_firstNameController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              isClicked == 1) {
                                                            // print(
                                                            //     _firstNameController
                                                            //         .text);
                                                            // if (isClicked ==
                                                            //     1) {

                                                            //     }

                                                            authController
                                                                .updateName(
                                                                    _firstNameController
                                                                        .text
                                                                        .toString())
                                                                .then((value) {
                                                              if (value
                                                                      .success ??
                                                                  false) {
                                                                _firstNameController
                                                                    .clear();

                                                                // print(value
                                                                //     .message
                                                                //     .toString());

                                                                userController
                                                                    .userData();

                                                                showCustomSnackBar(
                                                                    value
                                                                        .message
                                                                        .toString(),
                                                                    context,
                                                                    isError:
                                                                        false);

                                                                userController
                                                                    .setLoadingValue(
                                                                        false);
                                                                isClicked = 0;
                                                                // print(
                                                                //     'object ------>$isClicked');
                                                                Navigator.pop(
                                                                    context);

                                                                // Get.offNamed(
                                                                //     RouteHelper
                                                                //         .getInitialRoute());

                                                                // Get.offNamed(RouteHelper
                                                                //     .getInitialRoute());
                                                                // Get.offNamed(RouteHelper
                                                                //     .getInitialRoute());

                                                              } else {
                                                                showCustomSnackBar(
                                                                    'Please Enter your name!',
                                                                    context,
                                                                    isError:
                                                                        true);
                                                                // Get.offNamed(RouteHelper.getInitialRoute());
                                                              }
                                                            });
                                                          } else {
                                                            showCustomSnackBar(
                                                                'Please Enter your name!!',
                                                                context,
                                                                isError: true);
                                                            setState(() {
                                                              isClicked = 0;
                                                            });
                                                          }
                                                        });
                                                  })
                                                ],
                                              )),

                                          barrierColor:
                                              Colors.black.withOpacity(0.5),
                                          isDismissible: true,

                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(35),
                                          // ),
                                          enableDrag: true,
                                        );
                                      },
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFDCE41),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Image.asset(
                                          Get.isDarkMode
                                              ? Images.profileLightMode
                                              : Images.profileDarkMode,
                                          scale: 3,
                                          color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                      onTap: () => Get.find<ThemeController>()
                                          .toggleTheme(),
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF6DAA),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Image.asset(
                                          Images.profileLogout,
                                          color: Theme.of(context).cardColor,
                                          scale: 3,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.dialog(
                                            ConfirmationDialog(
                                                icon: Lottie.asset(
                                                    Images.warningDelete,
                                                    height: 120,
                                                    width: 120),
                                                description:
                                                    'Are you sure to logout?',
                                                isLogOut: true,
                                                onYesPressed: () {
                                                  Get.find<AuthController>()
                                                      .logout();
                                                  Get.offAllNamed(RouteHelper
                                                      .getSignInRoute('Login'));
                                                }),
                                            useSafeArea: false);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Recently Quiz',
                                        style: poppinsMedium.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_LARGE,
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'All',
                                          style: poppinsRegular.copyWith(
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_LARGE,
                                          ),
                                        ),
                                        onTap: () {
                                          // Get.find<UserController>().userData();
                                          // quizController.testPrint();
                                          // print("ksjdhjk ----->" +
                                          //     quizController
                                          //         .getHighUserScore()
                                          //         .toString());
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: quizController.records.isEmpty
                                      ? true
                                      : false,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(top: 100),
                                        child:
                                            const Text("No records are found"),
                                      ),
                                      const Center(
                                        child: LoadingLottie(
                                          height: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemCount: quizController.records.length,
                                      separatorBuilder: (__, _) =>
                                          const SizedBox(height: 15),
                                      itemBuilder: (context, index) {
                                        var reverselist = quizController
                                            .records.reversed
                                            .toList();
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 90,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? Colors.grey[800]
                                                  : Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(Dimensions
                                                          .RADIUS_LARGE)),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color(0xFF0F0D2388),
                                                    offset: Offset(10, 24),
                                                    blurRadius: 54)
                                              ]),
                                          child: ListTile(
                                            leading: Container(
                                              alignment: Alignment.center,
                                              // padding:
                                              // EdgeInsets.symmetric(vertical: 20),
                                              // margin: const EdgeInsets.all(8),
                                              // height: 80,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                color: lController
                                                    .listColor[index],
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                              ),
                                              child: Text(
                                                '${index + 1}',
                                                style: poppinsBold.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_EXTRA_LARGE,
                                                    color: Theme.of(context)
                                                        .cardColor),
                                              ),
                                            ),
                                            title: Text(
                                              reverselist[index]
                                                  .time
                                                  .toString(),
                                              style: poppinsBold.copyWith(
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_EXTRA_LARGE,
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                            trailing: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      width: 5,
                                                      color: lController
                                                          .listColor[index])),
                                              child: Text(
                                                reverselist[index]
                                                    .record
                                                    .toString(),
                                                style: poppinsBold.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_EXTRA_LARGE,
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          )
                        ])
                  : const Center(
                      child: LoadingLottie(
                        height: 300,
                      ),
                    ),
            );
          });
        });
      }),
    );
  }
}
