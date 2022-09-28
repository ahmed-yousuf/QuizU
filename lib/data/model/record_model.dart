class Record {
  final String? record;
  final String? time;
  final String?
      key; // not an actual Key but will take the String value of a UniqueKey

  Record({this.key, this.record, this.time});
}
