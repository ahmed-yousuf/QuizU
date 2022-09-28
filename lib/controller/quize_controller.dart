import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quizu/controller/auth_controller.dart';
import 'package:quizu/data/model/quiz_model.dart';
import 'package:quizu/data/response/response_model.dart';
import 'package:quizu/util/app_constants.dart';

import '../data/model/record_model.dart';

class QuizController extends GetxController implements GetxService {
  QuizModel? _quizModel;
  QuizModel? get quizModel => _quizModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<QuizModel> _quizList = [];
  List<QuizModel> get quizList => _quizList;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  int _attempts = 0;
  int get attempts => _attempts;

  int _scores = 0;
  int get scores => _scores;

  String _quizTime = '';
  String get quizTime => _quizTime;

  String _selectedAnswer = '';
  String get selectedAnswer => _selectedAnswer;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void attemptsUser() {
    _attempts++;
  }

  void resetAttmpts() {
    _attempts = 0;
  }

  void saveScoreToLocalList({required String score, required time}) {
    final record = Record(record: score, time: time);
    addAndStoreRecord(record);
  }

  //----------------------------------------------->
  final List<Record> _record = [];
  List<Record> get records => _record;

  final box = GetStorage();
  List storageList = [];

  void addAndStoreRecord(Record record) {
    _record.add(record);

    final storageMap = {}; // temporary map that gets added to storage
    final index = _record.length; // for unique map keys
    final recordKey = 'record$index';
    final timeKey = 'time$index';

    storageMap[recordKey] = record.record;
    storageMap[timeKey] = record.time;

    storageList.add(storageMap);
    box.write('records', storageList);
  }

  void restoreRecord() {
    storageList = box.read('records');
    String recordKey, timeKey;

    for (int i = 0; i < storageList.length; i++) {
      final map = storageList[i];
      // index for retreival keys accounting for index starting at 0
      final index = i + 1;

      recordKey = 'record$index';
      timeKey = 'time$index';

      final record = Record(record: map[recordKey], time: map[timeKey]);

      _record.add(record);
    }
  }

  void clearRecord() {
    _record.clear();
    storageList.clear();
    box.erase();
  }

// looping through you list to see whats inside
  void printRecord() {
    for (int i = 0; i < _record.length; i++) {
      debugPrint(
          'Task ${i + 1} record ${_record[i].record} time: ${_record[i].time}');
    }
  }

  String? getHighUserScore() {
    if (_record.isEmpty) {
      return "0";
    } else {
      var value = _record.reduce(
          (a, b) => int.parse(a.record!) > int.parse(b.record!) ? a : b);

      return value.record;
    }
  }
  //----------------------------------------------->

  void testPrint() {
    printRecord();
    if (kDebugMode) {
      print(_record.length);
    }
  }

  void setSelectedAnswer(String answer) {
    _selectedAnswer = answer;
    update();
  }

  void reSetResult() {
    _scores = 0;
    update();
  }

  void setQuizTime(String time) {
    _quizTime = time;
    update();
  }

  bool setResult(int index, String answer) {
    if (answer == _quizList[index].correct) {
      _scores++;
      update();
      // print("My Scores: ----->" + _scores.toString());

      return true;
    }
    return false;
  }

  // final String _myToken = Get.find<AuthController>().getMyToken();

  Future getQuiz() async {
    _isLoading = true;
    update();
    final http.Response response = await http.get(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.QUESTIONS_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Get.find<AuthController>().getMyToken()}'
      },
    );
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      Iterable data = json.decode(response.body);
      // print('Leadder Infoooo new ------->' + data.toString());
      _quizList =
          List<QuizModel>.from(data.map((model) => QuizModel.fromJson(model)));
      _isLoading = true;
      update();
      // return _userTopList;
    } else if (response.statusCode == 401) {
      // _topUserModel = TopUserModel.fromJson(json.decode(response.body));
      update();
    } else {
      throw Exception('Token vaild failed!');
    }
  }

  Future<ResponseModel> postScore() async {
    final http.Response response = await http.post(
      Uri.parse('${AppConstants.BASE_URL}${AppConstants.POST_SCORE_URI}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${Get.find<AuthController>().getMyToken()}'
      },
      body: jsonEncode(<String, String>{'score': "$_scores"}),
    );
    if (response.statusCode == 201) {
      // final data = jsonDecode(response.body);
      ResponseModel.fromJson(json.decode(response.body));
      // print("Score Post Sucessfully---------->");

      return ResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Post Score failed!');
    }
  }

  @override
  void onInit() {
    getQuiz();
    if (box.read('records') != null) {
      restoreRecord();
    }
    super.onInit();
  }
}
