import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/Screen/home/bottom_nav.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:share/share.dart';

class WinScreen extends StatefulWidget {
  const WinScreen({Key? key}) : super(key: key);

  @override
  State<WinScreen> createState() => _WinScreenState();
}

class _WinScreenState extends State<WinScreen> {
  // bool _isLoading1 = false;
  // bool _isLoading2 = false;
  DateTime now = DateTime.now();

  // void onTime() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     setState(() {
  //       _isLoading1 = true;
  //     });
  //   });
  // }

  // void onSecondTime() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     setState(() {
  //       _isLoading2 = true;
  //     });
  //   });
  // }

  @override
  void initState() {
    Get.find<QuizController>().postScore();
    // Get.find<QuizController>().myList();

    Get.find<QuizController>().saveScoreToLocalList(
        score: '${Get.find<QuizController>().scores}',
        time: DateFormat.jm().format(now) + " " + DateFormat.yMd().format(now));
    // onTime();
    // onSecondTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Get.isDarkMode ? Images.leaderboardBgDark : Images.leaderboardBg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.350,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  left: 0,
                  child: Lottie.asset(Images.win4),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  child: Lottie.asset(
                    Images.win,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  child: Lottie.asset(
                    Images.win2,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Congratulations',
                          style: poppinsBold.copyWith(
                              color: Colors.white, fontSize: 34),
                        ),
                        Text(
                          Get.find<UserController>()
                              .userDataModel!
                              .name
                              .toString(),
                          style: poppinsBold.copyWith(
                              color: Colors.amber, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 80,
            width: 190,
            child: Text(
              'Score: ${Get.find<QuizController>().scores}',
              style: poppinsBold.copyWith(
                  fontSize: 30, color: Theme.of(context).primaryColor),
            ),
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.bottomLeft,
            height: Get.height * 0.45,
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'Share your winnings with all your friends and invite them to join to play',
                    textAlign: TextAlign.center,
                    style: poppinsRegular.copyWith(
                        fontSize: 18, color: Colors.grey),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: Cros,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8270F6),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        Images.telegram,
                        scale: 12,
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD967),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        Images.facebook,
                        scale: 12,
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6DAA),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        Images.whatsapp,
                        scale: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CustomButton(
                  buttonText: 'Share',
                  fontSize: 18,
                  textColor: Colors.white,
                  transparent: true,
                  buttonColor: const Color(0xFFFF6DAA),
                  onPressed: () {
                    Share.share(
                        'I answered ${Get.find<QuizController>().scores} correct answers in QuizU!');
                  },
                ),
                TextButton(
                    onPressed: () {
                      Get.find<QuizController>().setSelectedAnswer('');
                      Get.find<QuizController>().setSelectedIndex(0);
                      Get.find<QuizController>().reSetResult();
                      Get.offAllNamed(RouteHelper.getInitialRoute(),
                          arguments: BottomBar(selectedIndex: 2));
                    },
                    child: Text(
                      'Skip',
                      style: poppinsMedium.copyWith(fontSize: 18),
                    )),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
