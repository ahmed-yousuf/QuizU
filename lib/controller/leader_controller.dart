import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/data/model/top_user_model.dart';
import 'package:quizu/util/app_constants.dart';

class LeaderController extends GetxController implements GetxService {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserTopModel? _topUserModel;
  List<UserTopModel>? _userTopList;
  List<UserTopModel>? get topUserList => _userTopList;
  UserTopModel get topUserModel => _topUserModel!;

  Future topUserData() async {
    _isLoading = true;
    update();
    final http.Response response = await http.get(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.TOP_TEN_SCORES_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Get.find<AuthController>().getMyToken()}'
      },
    );
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      Iterable data = json.decode(response.body);
      print('Leadder Infoooo  ------->' + data.toString());
      _userTopList = List<UserTopModel>.from(
          data.map((model) => UserTopModel.fromJson(model)));
      _isLoading = false;
      update();
      // return _userTopList;
    } else if (response.statusCode == 401) {
      print("Error ---------> Loading Leader Board!!! ");
      // _topUserModel = TopUserModel.fromJson(json.decode(response.body));

    } else {
      throw Exception('Token vaild failed!');
    }
  }

  final List<Color> listColor = [
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
    const Color(0xFF8270F6),
    const Color(0xFFFFD967),
    const Color(0xFFFF6DAA),
  ];

  @override
  void onInit() {
    topUserData();
    super.onInit();
  }
}
