class Plan {
  int id;
  String title;
  String date;

  Plan({this.id = 0, this.title = '', this.date = ''});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'date': date};
  }
}
