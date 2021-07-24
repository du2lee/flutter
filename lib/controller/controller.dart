import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Controller extends GetxService{
  
  RxList<String> todoListTitle = <String>[].obs;
  RxList<String> todoListDate = <String>[].obs;
  RxInt planIndex = 0.obs;
  RxBool editFlag = false.obs;
  
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('MMM dd, yyyy').format(DateTime.now()));
  DateFormat dateFormatter = DateFormat('MMM dd, yyyy');

  List<String> get getTitle => todoListTitle;
  List<String> get getDate => todoListDate;
  int get getListSize => todoListTitle.length;
  bool get getEditFlag => editFlag.value;

  @override
  void onClose() {
    dateController.dispose();
    titleController.dispose();
    super.onClose();
   }

  void add(){
    todoListTitle.add(titleController.text);
    todoListDate.add(dateController.text);
    Get.back();
  }

  void delete(int index) {
      todoListTitle.removeAt(index);
      todoListDate.removeAt(index);
  }

  void goAddPage(){
    editFlag = false.obs;
    dateController.text = '';
    titleController.text = '';
    Get.toNamed('/add');
  }

  void goEditPage(int index){
    planIndex = index.obs;
    editFlag = true.obs;
    dateController.text = todoListDate[index];
    titleController.text = todoListTitle[index];
    Get.toNamed('/add');
  }

  void openDatePicker(BuildContext context, DateTime _date) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
        _date = date;
      dateController.text = dateFormatter.format(date);
    }
  }

}
