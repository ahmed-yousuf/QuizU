// ignore_for_file: prefer_collection_literals

class QuizModel {
  String? question;
  String? a;
  String? b;
  String? c;
  String? d;
  String? correct;

  QuizModel({this.question, this.a, this.b, this.c, this.d, this.correct});

  QuizModel.fromJson(Map<String, dynamic> json) {
    question = json['Question'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    correct = json['correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Question'] = question;
    data['a'] = a;
    data['b'] = b;
    data['c'] = c;
    data['d'] = d;
    data['correct'] = correct;
    return data;
  }
}
