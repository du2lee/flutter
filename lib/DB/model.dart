//https://pub.dev/packages/sqflite
final String columnId = 'id';
final String columnTitle = 'title';
final String columnDate = 'date';

class Plan{
  late final int? id;
  late final String title;
  late final String date;

  Plan({this.id, required this.title, required this.date});     

  Map<String, dynamic> toMap(){
    var map =  {
      columnTitle : title,
      columnDate : date,
    };
    if (id != null){
      map[columnId] = id as String;
    }
    return map;
  }

  Plan.fromMap(Map<String, dynamic> map){
    id = map[columnId];
    title = map[columnTitle];
    date = map[columnDate];
  }

}