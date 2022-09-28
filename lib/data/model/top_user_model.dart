// ignore_for_file: prefer_collection_literals

class UserTopModel {
  String? name;
  int? score;

  UserTopModel({this.name, this.score});

  UserTopModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['score'] = score;
    return data;
  }
}
