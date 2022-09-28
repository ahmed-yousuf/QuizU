// ignore_for_file: prefer_collection_literals

class UserInfoModel {
  bool? success;
  String? message;
  String? name;
  String? mobile;

  UserInfoModel({this.success, this.message, this.name, this.mobile});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
