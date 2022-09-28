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

  final String _myToken = Get.find<AuthController>().myToken;

  Future userData() async {
    _isLoading = true;
    update();
    final http.Response response = await http.get(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.USER_INFO_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_myToken'
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      _userDataModel = UserDataModel.fromJson(json.decode(response.body));
      _isLoading = false;
      update();
      return UserDataModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      // print('Error Infoooo new ------->');

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
