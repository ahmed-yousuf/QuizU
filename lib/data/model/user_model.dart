// ignore_for_file: prefer_collection_literals

class UserModel {
  bool? success;
  String? message;
  String? token;
  String? name;
  String? mobile;
  String? userStatus;

  UserModel(
      {this.success,
      this.message,
      this.token,
      this.name,
      this.mobile,
      this.userStatus});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    name = json['name'];
    mobile = json['mobile'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    data['name'] = name;
    data['mobile'] = mobile;
    data['user_status'] = userStatus;

    return data;
  }
}
