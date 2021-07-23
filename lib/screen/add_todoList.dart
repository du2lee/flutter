import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist/controller/controller.dart';

class AddTodoListPage extends StatefulWidget {
  bool flag = Get.arguments;
  @override
  _AddTodoListPageState createState() => _AddTodoListPageState();
}

class _AddTodoListPageState extends State<AddTodoListPage> {
  final formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final TextEditingController _dateController = TextEditingController(
      text: DateFormat('MMM dd, yyyy').format(DateTime.now()));
  TextEditingController titleController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.flag ? 'Add Plan': 'Edit Plan',
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
                      controller: titleController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      readOnly:
                          true, //datePicker에서 지정한 날짜만 표시하기 위해 읽기전용으로 설정하였습니다.
                      controller: _dateController, //date
                      onTap: _handleDatePicker, //date 부분 클릭시 datePicker가 열립니다.
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
                              Get.find<Controller>().add(titleController.text, _dateController.text);
                              Get.back();
                            }
                          },
                          child: Text(
                            widget.flag ?'ADD':'EDIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          )))
                ],
              )),
        ));
  }

  _handleDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }
}
