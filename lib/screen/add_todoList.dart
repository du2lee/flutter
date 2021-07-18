import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todolist/DB/db.dart';
import 'package:todolist/DB/model.dart';


class AddTodoListPage extends StatefulWidget {
  @override
  _AddTodoListPageState createState() => _AddTodoListPageState();
}

class _AddTodoListPageState extends State<AddTodoListPage> {
  String title = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Add Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ))),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Form(
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
                        validator: (input) => input!.trim().isEmpty
                            ? 'Please enter a task'
                            : null,
                        controller: titleController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        readOnly: true,                       //datePicker에서 지정한 날짜만 표시하기 위해 읽기전용으로 설정하였습니다.
                        controller: _dateController, //date
                        onTap: _handleDatePicker,             //date 부분 클릭시 datePicker가 열립니다.
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
                              this.title = this.titleController.text;
                              print('$title, $_date');         //확인용


                              Navigator.pop(context);          // 버튼 클릭시 화면에서 빠져 나옵니다.
                            },
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            )))
                  ],
                )),
          ),
        ));
  }

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  Future<void> insert() async{
    var provider = DBHelper();
    var plan = Plan(title: this.title, date: this._date.toString());
    provider.insert(plan);
  }
}