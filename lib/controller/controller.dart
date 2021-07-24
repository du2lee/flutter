import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Controller{
  
  RxList todoListTitle = [].obs;
  RxList todoListDate = [].obs;
  RxInt planIndex = 0.obs;
  RxBool editFlag = false.obs;
  
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('MMM dd, yyyy').format(DateTime.now()));
  DateFormat dateFormatter = DateFormat('MMM dd, yyyy');

  List get getTitle => todoListTitle;
  List get getDate => todoListDate;
  int get getListSize => todoListTitle.length;

  // @override
  // void onClose() {
  //   dateController.dispose();
  //   titleController.dispose();
  //   super.onClose();
  // }

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
    Get.toNamed('/add');
    editFlag = false.obs;
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
