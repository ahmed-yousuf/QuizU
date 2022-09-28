import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/controller/leader_controller.dart';
import 'package:quizu/controller/onboarding_controller.dart';
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/splash_controller.dart';
import 'package:quizu/controller/theme_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/data/repository/onboarding_repo.dart';
import 'package:quizu/data/repository/splash_repo.dart';

Future<void> init() async {
  // Core
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(
  //     appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => GetStorage());

  Get.lazyPut(() => SplashRepo(getStorage: Get.find()));
  Get.lazyPut(() => OnBoardingRepo());

  //Omar added the apiClient to the LanguageRepo in get init KING .

  // Get.lazyPut(
  //     () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController());
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => OnBoardingController(onboardingRepo: Get.find()));
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => LeaderController());
  Get.lazyPut(() => QuizController());

  // return '';
}
