// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/controller/quize_controller.dart';
import 'package:quizu/controller/user_controller.dart';
import 'package:quizu/data/api/client_helper.dart';
import 'package:quizu/data/model/user_info_model.dart';
import 'package:quizu/data/model/user_model.dart';
import 'package:quizu/data/response/response_model.dart';
import 'package:quizu/helper/route_helper.dart';
import 'package:quizu/util/app_constants.dart';

class AuthController extends GetxController implements GetxService {
  UserModel? _userModel;
  UserInfoModel? _userInfoModel;
  UserModel? get userModel => _userModel;

  GetStorage _userName = GetStorage();
  GetStorage get userName => _userName;

  GetStorage _userNumber = GetStorage();
  GetStorage get userNumber => _userNumber;

  UserInfoModel? get userInfoModel => _userInfoModel;
  ResponseModel? _responseModel;
  ResponseModel? get responseModel => _responseModel;

  GetStorage _saveToken = GetStorage();
  GetStorage get saveToken => _saveToken;
  String _myToken = '';
  String get myToken => _myToken;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  void updateVerificationCode(String query) {
    _verificationCode = replaceArabicNumber(query);

    update();
  }

  void setUserName(String name) {
    _userName.write(AppConstants.USER_NAME, name);
    update();
  }

  void setUserNumber(String number) {
    _userNumber.write(AppConstants.USER_NUMBER, number);
    update();
  }

  void setSaveToken(String token) {
    _saveToken.write(AppConstants.TOKEN, token);
    update();
  }

  String getSaveName() {
    return _userName.read(AppConstants.USER_NAME) ?? 'null';
  }

  String getSaveNumber() {
    return _userNumber.read(AppConstants.USER_NUMBER) ?? "Your Number";
  }

  String getMyToken() {
    if (_saveToken.read(AppConstants.TOKEN) == null) {
      return _myToken = '';
    } else {
      return _myToken = _saveToken.read(AppConstants.TOKEN);
    }
    //  _myToken;
  }

  Future<UserModel> login(String mobile, String otp) async {
    _isLoading = true;
    update();
    final http.Response response = await http.post(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.LOGIN_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'OTP': otp,
      }),
    );
    if (response.statusCode == 201) {
      _userModel = UserModel.fromJson(json.decode(response.body));
      setSaveToken(_userModel!.token.toString());
      print("UserToken---------->" + _userModel!.token.toString());
      // print("UserToken2---------->" + getMyToken());
      _isLoading = false;
      // Get.find<LeaderController>().topUserData();
      // Get.find<QuizController>().getQuiz();
      // Get.find<UserController>().userData();
      update();

      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Login loading failed!');
    }
  }

  Future<UserInfoModel> updateName(
    String name,
  ) async {
    _isLoading = true;
    update();
    // print(_myToken);
    final http.Response response = await http.post(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.UPDATE_USER_NAME_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_myToken'
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('UserInfoModel ------->' + data.toString());

      _userModel = UserModel.fromJson(json.decode(response.body));
      _isLoading = false;
      update();
      setSaveToken(_userModel!.token.toString());
      Get.find<UserController>().userData();

      return UserInfoModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return UserInfoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Update name failed!');
    }
  }

  Future<bool> getTokenVerify() async {
    _isLoading = true;
    update();
    final response = await ClientHelper.getData(
        '${AppConstants.BASE_URL}${AppConstants.VERIFY_TOKEN_URI}', _myToken);
    try {
      final data = jsonDecode(response!.body);

      _responseModel = ResponseModel.fromJson(data);
      _isLoading = false;
      update();
      return _responseModel!.success ?? false;
    } catch (e) {
      log(e.toString());
    }

    return _responseModel!.success == null
        ? false
        : _responseModel!.success ?? false;
  }

  Future<ResponseModel> verfiyToken() async {
    _isLoading = true;
    update();
    print("MyToken----->" + _myToken.toString());
    final http.Response response = await http.get(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.VERIFY_TOKEN_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_myToken'
      },
    );
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // print('ResponseModel ------->' + data.toString());
      _responseModel = ResponseModel.fromJson(json.decode(response.body));
      _isLoading = false;
      update();
      return ResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      _responseModel = ResponseModel.fromJson(json.decode(response.body));
      update();
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      _isLoading = false;
      update();
      throw Exception('Token vaild failed!');
    }
  }

  void logout() {
    setSaveToken('');
    Get.find<QuizController>().clearRecord();
    Get.find<QuizController>().resetAttmpts();
    Get.offNamed(RouteHelper.getSignInRoute('sign'));
    update();
  }

  @override
  void onInit() {
    verfiyToken();
    super.onInit();
  }
}
