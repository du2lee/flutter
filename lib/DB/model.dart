class Plan{
  final int id;
  final String title;
  final String date;

  Plan({required this.id, required this.title, required this.date});          //각각 값이 다 들어갈 것이기에 required를 주었습니다.


  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'date' : date,
    };
  }

}