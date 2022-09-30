// ignore_for_file: unnecessary_string_interpolations

import 'package:get/get.dart';
import 'package:quizu/view/Screen/auth/signin_screen.dart';
import 'package:quizu/view/Screen/auth/verification_screen.dart';
import 'package:quizu/view/Screen/home/bottom_nav.dart';
import 'package:quizu/view/Screen/onboard/onboarding_screen.dart';
import 'package:quizu/view/Screen/profile/profile_screen.dart';
import 'package:quizu/view/Screen/quiz/quiz_screen.dart';
import 'package:quizu/view/Screen/splash/splash_screen.dart';
import 'package:quizu/view/Screen/win/win_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String onBoarding = '/on-boarding';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String quiz = '/quiz';
  static const String win = '/win';
  static const String profile = '/profile';

  // static const String updateName = '/updateename';

  // static const String signIn = '/sign-in';
  // static const String verification = '/verification';
  // static const String main = '/main';

  static String getInitialRoute() => '$initial';
  static String getSplashRoute() => '$splash';
  static String getOnBoardingRoute() => '$onBoarding';
  static String getSignInRoute(String page) => '$signIn?page=$page';

  static String getVerificationRoute(
    bool isLogin,
    String number,
    String page,
  ) {
    return '$verification?page=$page&number=$number';
  }

  static String getQuizRoute() => '$quiz';
  static String getWinRoute() => '$win';
  static String getProfileRoute() => '$profile';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          BottomBar _bottomBar = Get.arguments;
          return _bottomBar;
        }),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    GetPage(
        name: signIn,
        page: () => SignInScreen(
              exitFromApp: Get.parameters['page'] == splash ||
                  Get.parameters['page'] == onBoarding,
            )),
    GetPage(
        name: verification,
        page: () {
          return VerificationScreen(
            number: Get.parameters['number'],
          );
        }),
    GetPage(name: quiz, page: () => const QuizScreen()),
    GetPage(name: win, page: () => const WinScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
  ];
}
