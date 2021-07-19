final String tableName = 'plans';

class PlanFields {
  static final String id = '_id';
  static final String title = 'title';
  static final String date = 'date';
}

class Plan{
  final int? id;
  final String title;
  final String date;

  const Plan({this.id, required this.title, required this.date});

  Plan copy({
    int? id,
    String? title = 'title',
    String? date = 'date',
  }) =>
      Plan(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
      );

  Map<String, Object?> toJson() => {
    PlanFields.id: id,
    PlanFields.title: title,
    PlanFields.date: date,

  };

}