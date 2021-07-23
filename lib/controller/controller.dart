import 'package:get/get.dart';

class Controller{
  RxList todoListTitle = [].obs;
  RxList todoListDate = [].obs;

  RxList get getTitle => todoListTitle;
  RxList get getDate => todoListDate;
  int get getListSize => todoListTitle.length;

  void add(String title,String date){
    todoListTitle.add(title);
    todoListDate.add(date);
  }

  void delete(int index) {
      todoListTitle.removeAt(index);
      todoListDate.removeAt(index);
  }
}
