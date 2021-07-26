class Plan {
  int? id;
  String title;
  String date;
  bool ipt;

  Plan({this.id, this.title = '', this.date = '', this.ipt = false});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'date': date, 'ipt': ipt};
  }
}
