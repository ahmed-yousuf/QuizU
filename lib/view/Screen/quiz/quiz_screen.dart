import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/dimensions.dart';
import 'package:quizu/util/images.dart';
import 'package:quizu/util/styles.dart';
import 'package:quizu/view/Screen/home/bottom_nav.dart';
import 'package:quizu/view/base/confirmation_dialog.dart';
import 'package:quizu/view/base/custom_button.dart';
import 'package:quizu/view/base/custom_loader.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _stopTimer = false;
  late CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 120000;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final quizControll = Get.find<QuizController>();
  DateTime now = DateTime.now();

  bool isSkipped = false;
  bool stopTime = true;
  int step = 0;
  late bool _allow;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    super.didChangeDependencies();
  }

  void onEnd() {
    if (Get.find<QuizController>().scores == 0) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: Get.height * 0.350,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(Images.wrong, height: 80),
                      Text(
                        Get.find<QuizController>().scores == 0
                            ? "Time up you didn't select any option!!"
                            : 'Wrong Answer!',
                        style: poppinsRegular.copyWith(
                            fontSize: Get.find<QuizController>().scores == 0
                                ? 16
                                : 23),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.find<QuizController>().setSelectedAnswer('');
                          Get.find<QuizController>().setSelectedIndex(0);
                          Get.find<QuizController>().reSetResult();
                          Get.find<QuizController>().attemptsUser();

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                          setState(() {
                            DateTime.now().millisecondsSinceEpoch + 0;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 120,
                          child: Text(
                            'Try Again!',
                            style: poppinsBold.copyWith(
                                fontSize: 18, color: Colors.white),
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFFFF6DAA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.find<QuizController>().attemptsUser();
                          Get.offAllNamed(RouteHelper.getInitialRoute(),
                              arguments: BottomBar(selectedIndex: 0));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 120,
                          child: Text(
                            'Exit quiz!',
                            style: poppinsBold.copyWith(
                                fontSize: 18, color: Colors.white),
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF8270F6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Get.offNamed(RouteHelper.win);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void answer(int index, String option, String answer) {
    Get.find<QuizController>().setSelectedAnswer(answer);

    if (Get.find<QuizController>().setResult(index, option)) {
      setState(() {
        if (Get.find<QuizController>().scores == 30) {
          Get.offNamed(RouteHelper.win);
          endTime = 0;
          stopTime = false;
          _stopTimer = true;
        }
        step = index + 1;
        if (step > 29) {
          step = index;
        }
        _pageController.animateToPage(
          step,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    } else {
      setState(() {
        Get.find<QuizController>().resetScores();
        endTime = 0;
        stopTime = false;
        _stopTimer = true;
      });

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: Get.height * 0.350,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(Images.wrong, height: 80),
                      Text(
                        'Wrong Answer!',
                        style: poppinsRegular.copyWith(fontSize: 23),
                      ),
                      TextButton(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 120,
                          child: Text(
                            'Try Again!',
                            style: poppinsBold.copyWith(
                                fontSize: 18, color: Colors.white),
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFFFF6DAA),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        onPressed: () {
                          setState(() {
                            endTime = 0;
                            stopTime = false;
                            _stopTimer = true;
                          });
                          Get.find<QuizController>().setSelectedAnswer('');
                          Get.find<QuizController>().setSelectedIndex(0);
                          Get.find<QuizController>().reSetResult();
                          Get.find<QuizController>().attemptsUser();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            endTime = 0;
                            stopTime = false;
                            _stopTimer = true;
                          });
                          Get.offNamed(RouteHelper.getInitialRoute(),
                              arguments: BottomBar(selectedIndex: 0));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 120,
                          child: Text(
                            'Exit quiz!',
                            style: poppinsBold.copyWith(
                                fontSize: 18, color: Colors.white),
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFF8270F6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.dialog(
            ConfirmationDialog(
                icon:
                    Lottie.asset(Images.warningDelete, height: 120, width: 120),
                description: 'Are you sure to Exit from quiz?',
                isLogOut: true,
                onNoPressed: () => _allow = true,
                onYesPressed: () {
                  setState(() {
                    endTime = 0;
                    stopTime = false;
                    _stopTimer = true;
                    Get.offAllNamed(RouteHelper.getInitialRoute(),
                        arguments: BottomBar(selectedIndex: 0));
                  });
                }),
            useSafeArea: false);
        return Future.value(_allow);
      },
      child: Scaffold(
        body: GetBuilder<QuizController>(builder: (quizContoller) {
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
              child: quizControll.isLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              controller: _scrollController,
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: quizContoller.quizList.length,
                              separatorBuilder: (_, __) => const SizedBox(
                                width: 15,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          quizContoller.selectedIndex == index
                                              ? const Color(0xFFFF6DAA)
                                              : Colors.grey.withOpacity(0.3)),
                                  child: Center(
                                      child: Text(
                                    '${index + 1}',
                                    style: poppinsBold.copyWith(
                                      color:
                                          quizContoller.selectedIndex == index
                                              ? Colors.white
                                              : Colors.white54,
                                    ),
                                  )),
                                );
                              },
                            ),
                          ),
                          Center(
                            child: Text(
                              'Quiz Me!',
                              style: poppinsBold.copyWith(
                                  fontSize:
                                      Dimensions.FONT_SIZE_EXTRA_LARGE + 10,
                                  color: Colors.white),
                            ),
                          ),
                          Center(
                            child: CountdownTimer(
                              endTime: _stopTimer ? 0 : endTime,
                              onEnd: _stopTimer ? null : onEnd,
                              widgetBuilder: (_, CurrentRemainingTime? time) {
                                // print("Time ------------>: " + time.toString());
                                if (time == null || !stopTime) {
                                  return Text(
                                    stopTime ? 'Time Stoped' : 'Game Over',
                                    style: poppinsRegular.copyWith(
                                        color: Colors.white),
                                  );
                                }
                                return Text(
                                  '${time.min == null ? "00" : time.min == 1 ? "01" : ""}:${time.sec! < 10 ? "0" : ""}${time.sec ?? ''}',
                                  style: poppinsBlack.copyWith(
                                      fontSize:
                                          Dimensions.FONT_SIZE_EXTRA_LARGE + 5,
                                      color: (time.min == null &&
                                              time.sec! < 31)
                                          ? (time.min == null && time.sec! < 11)
                                              ? Colors.redAccent.shade400
                                              : Colors.amber.shade500
                                          : Colors.white),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 500,
                            child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _pageController,
                                onPageChanged: (value) {
                                  if (value < 25) {
                                    _scrollController.animateTo(
                                        (65 * value).toDouble(),
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  }

                                  quizContoller.setSelectedIndex(value);
                                },
                                itemCount: quizContoller.quizList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        height: Get.height * 0.220,
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: 1,
                                            itemBuilder: ((context, i) {
                                              return Container(
                                                alignment: Alignment.center,
                                                // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                                // margin: const EdgeInsets.symmetric(
                                                //     horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                                height: Get.height * 0.2,
                                                width: Get.width,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFF6DAA),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Text(
                                                  quizContoller
                                                      .quizList[index].question
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: poppinsMedium.copyWith(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              );
                                            })),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: Get.height * 0.250,
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 80,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  Images.charA),
                                                              fit:
                                                                  BoxFit.cover),
                                                          color: quizContoller
                                                                      .selectedAnswer ==
                                                                  quizContoller
                                                                      .quizList[
                                                                          index]
                                                                      .a
                                                                      .toString()
                                                              ? const Color(
                                                                  0xFFFF6DAA)
                                                              : const Color(
                                                                  0xFFA98EFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Text(
                                                        quizContoller
                                                            .quizList[index].a
                                                            .toString(),
                                                        style: poppinsBold.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_LARGE,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      answer(
                                                          index,
                                                          'a',
                                                          quizContoller
                                                              .quizList[index].a
                                                              .toString());
                                                      Future.delayed(
                                                          Duration(
                                                              microseconds:
                                                                  400), () {
                                                        quizContoller
                                                            .setSelectedAnswer(
                                                                '');
                                                      });
                                                      // quizContoller.setSelectedAnswer('');
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 80,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  Images.charB),
                                                              fit:
                                                                  BoxFit.cover),
                                                          color: quizContoller
                                                                      .selectedAnswer ==
                                                                  quizContoller
                                                                      .quizList[
                                                                          index]
                                                                      .b
                                                                      .toString()
                                                              ? const Color(
                                                                  0xFFFF6DAA)
                                                              : const Color(
                                                                  0xFFA98EFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Text(
                                                        quizContoller
                                                            .quizList[index].b
                                                            .toString(),
                                                        style: poppinsBold.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_LARGE,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      answer(
                                                          index,
                                                          'b',
                                                          quizContoller
                                                              .quizList[index].b
                                                              .toString());
                                                      Future.delayed(
                                                          const Duration(
                                                              microseconds:
                                                                  400), () {
                                                        quizContoller
                                                            .setSelectedAnswer(
                                                                '');
                                                      });
                                                      // quizContoller.setSelectedAnswer('');
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 80,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  Images.charC),
                                                              fit:
                                                                  BoxFit.cover),
                                                          color: (quizContoller
                                                                      .selectedAnswer ==
                                                                  quizContoller
                                                                      .quizList[
                                                                          index]
                                                                      .c
                                                                      .toString())
                                                              ? const Color(
                                                                  0xFFFF6DAA)
                                                              : const Color(
                                                                  0xFFA98EFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Text(
                                                        quizContoller
                                                            .quizList[index].c
                                                            .toString(),
                                                        style: poppinsBold.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_LARGE,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      answer(
                                                          index,
                                                          'c',
                                                          quizContoller
                                                              .quizList[index].c
                                                              .toString());
                                                      Future.delayed(
                                                          const Duration(
                                                              microseconds:
                                                                  400), () {
                                                        quizContoller
                                                            .setSelectedAnswer(
                                                                '');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: InkWell(
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      height: 80,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          image: const DecorationImage(
                                                              image: AssetImage(
                                                                  Images.charD),
                                                              fit:
                                                                  BoxFit.cover),
                                                          color: quizContoller
                                                                      .selectedAnswer ==
                                                                  quizContoller
                                                                      .quizList[
                                                                          index]
                                                                      .d
                                                                      .toString()
                                                              ? const Color(
                                                                  0xFFFF6DAA)
                                                              : const Color(
                                                                  0xFFA98EFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Text(
                                                        quizContoller
                                                            .quizList[index].d
                                                            .toString(),
                                                        style: poppinsBold.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_EXTRA_LARGE,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      answer(
                                                          index,
                                                          'd',
                                                          quizContoller
                                                              .quizList[index].d
                                                              .toString());
                                                      Future.delayed(
                                                          const Duration(
                                                              microseconds:
                                                                  400), () {
                                                        quizContoller
                                                            .setSelectedAnswer(
                                                                '');
                                                      });
                                                      // quizContoller.setSelectedAnswer('');
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          Text(
                            'Select a correct answer !',
                            style: poppinsRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                color: Colors.white70),
                          ),
                          // const Spacer(),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                              buttonText: "Skip",
                              textColor: Colors.white,
                              buttonColor: const Color(0xFFFF6DAA),
                              transparent: !isSkipped,
                              onPressed: () {
                                setState(() {
                                  if (!isSkipped) {
                                    _pageController.animateToPage(
                                      step + 1,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      curve: Curves.easeInOut,
                                    );

                                    isSkipped = true;
                                  }
                                });

                                // Get.defaultDialog();
                              },
                            ),
                          ),
                          // const Spacer(),
                        ],
                      ),
                    )
                  : const CustomLoader());
        }),
      ),
    );
  }
}
