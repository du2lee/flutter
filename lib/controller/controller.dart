import 'package:get/get.dart';

class Controller extends GetxController {
  List<String> todoListTitle = [];
  List<String> todoListDate = [];

  void add(addText){
    todoListTitle.add(addText['title']);
    todoListDate.add(addText['date']);
    update();
  }
}
