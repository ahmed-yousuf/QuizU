import 'package:get_storage/get_storage.dart';
import 'package:quizu/util/app_constants.dart';

class SplashRepo {
  final GetStorage getStorage;
  SplashRepo({
    required this.getStorage,
  });

  Future<bool> initSharedData() {
    if (getStorage.read(AppConstants.THEME) == null) {
      getStorage.write(AppConstants.THEME, false);
    }
    if (getStorage.read(AppConstants.INTRO) == null) {
      getStorage.write(AppConstants.INTRO, true);
    }

    return Future.value(true);
  }

  void disableIntro() {
    getStorage.write(AppConstants.INTRO, false);
  }

  bool? showIntro() {
    return getStorage.read(AppConstants.INTRO);
  }
}
