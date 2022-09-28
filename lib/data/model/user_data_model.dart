// ignore_for_file: prefer_collection_literals

class UserDataModel {
  String? mobile;
  String? name;

  UserDataModel({this.mobile, this.name});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mobile'] = mobile;
    data['name'] = name;
    return data;
  }
}
