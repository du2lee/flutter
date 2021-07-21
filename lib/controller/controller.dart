import 'package:get/get.dart';

class Controller extends GetxController {
  List<String> todoListTitle = [];
  List<String> todoListDate = [];

  List<String> get getTitle => todoListTitle;
  List<String> get getDate => todoListDate;

  int get getListSize => todoListTitle.length;

  void add(String title,String date){
    todoListTitle.add(title);
    todoListDate.add(date);
    update();
  }
}
