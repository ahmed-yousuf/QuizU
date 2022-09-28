import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/data/model/user_data_model.dart';
import 'package:quizu/util/app_constants.dart';

class UserController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserDataModel? _userDataModel;
  UserDataModel? get userDataModel => _userDataModel;

  void setLoadingValue(bool val) {
    _isLoading = val;
    update();
  }

  // final String _myToken = Get.find<AuthController>().getMyToken();

  Future userData() async {
    _isLoading = true;
    update();
    final http.Response response = await http.get(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.USER_INFO_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Get.find<AuthController>().getMyToken()}'
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _userDataModel = UserDataModel.fromJson(json.decode(response.body));
      print("UserToken---------->" + Get.find<AuthController>().getMyToken());
      print('User DATA Name ------->' + _userDataModel!.name.toString());
      print('User DATA Name ------->' + _userDataModel!.mobile.toString());

      _isLoading = false;
      update();
      return UserDataModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      update();
    } else {
      throw Exception('Token vaild failed!');
    }
  }

  @override
  void onInit() {
    userData();
    super.onInit();
  }
}
