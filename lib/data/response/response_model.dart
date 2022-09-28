// ignore_for_file: prefer_collection_literals

class ResponseModel {
  bool? success;
  String? message;

  ResponseModel({this.success, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
