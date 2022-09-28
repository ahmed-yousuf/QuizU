import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizu/util/app_constants.dart';

class SplashController extends GetxController implements GetxService {
  bool _firstTimeConnectionCheck = true;
  final bool _hasConnection = true;
  final GetStorage _showIntro = GetStorage();
  GetStorage get showIntro => _showIntro;
  bool _myIntro = true;
  bool get myIntro => _myIntro;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

  void setShowIntro(bool show) {
    _showIntro.write(AppConstants.INTRO, show);
    update();
  }

  bool getShowIntro() {
    // _myIntro = _showIntro.read(AppConstants.INTRO);
    // if (_showIntro.read(AppConstants.INTRO) == null) {
    //   return true;
    // } else {
    //   return _myIntro;
    // }
    _myIntro = _showIntro.read(AppConstants.INTRO) == null ? true : false;
    return _myIntro;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }
}
