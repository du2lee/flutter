import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/controller.dart';

class AddTodoListPage extends GetView<Controller> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              controller.getEditFlag ? 'Edit Plan' : 'Add Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ))),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      //title
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          labelText: 'Your Todo',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      validator: (input) =>
                          input!.trim().isEmpty ? 'Please enter a task' : null,
                      controller: controller.titleController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      readOnly:
                          true, //datePicker에서 지정한 날짜만 표시하기 위해 읽기전용으로 설정하였습니다.
                      controller: controller.dateController, //date
                      onTap: () => controller.openDatePicker(context, DateTime.now()), //date 부분 클릭시 datePicker가 열립니다.
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                  Container(
                      //summitButton
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: FlatButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.add();
                              Get.back();
                            }
                          },
                          child: Text(
                            controller.getEditFlag ? 'EDIT':'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          )))
                ],
              )),
        ));
  }
}
