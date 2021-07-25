import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/database/database_helper.dart';
import 'package:todolist/model/model.dart';

class Controller extends GetxService {
  RxList<Plan> todoList = <Plan>[].obs;
  RxBool editFlag = false.obs;
  int planIndex = 0;

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('MMM dd, yyyy').format(DateTime.now()));
  DateFormat dateFormatter = DateFormat('MMM dd, yyyy');

  List<Plan> get getPlan => todoList;
  int get getListSize => todoList.length;
  bool get getEditFlag => editFlag.value;

  @override
  void onInit(){
    DBHelper.instance.getAllPlans().then((value) => 
      value.forEach((element) {
        todoList.add(Plan(id: element['id'], title: element['title'], date: element['date']));
      }));
    super.onInit();
  }
  
  @override
  void onClose() {
    dateController.dispose();
    titleController.dispose();
    super.onClose();
  }

  Future<void> add() async {
    if (getEditFlag) {
      getPlan[planIndex].title = titleController.text;
      getPlan[planIndex].date = dateController.text;
      await DBHelper.instance.updatePlan(todoList[planIndex]);
    } else {
      var id = await DBHelper.instance.createPlan(
          Plan(title: titleController.text, date: dateController.text));
      todoList.add(
          Plan(id: id, title: titleController.text, date: dateController.text));
    }
    Get.back();
  }

  Future<void> delete(int index) async {
    await DBHelper.instance.deletePlan(todoList[index].id!);
    todoList.removeAt(index);
  }

  void goAddPage() {
    editFlag = false.obs;
    dateController.text = '';
    titleController.text = '';
    Get.toNamed('/add');
  }

  void goEditPage(int index) {
    planIndex = index;
    editFlag = true.obs;
    titleController.text = getPlan[planIndex].title;
    dateController.text = getPlan[planIndex].date;
    Get.toNamed('/add');
  }

  void goIptPage() {
    Get.toNamed('/point');
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
