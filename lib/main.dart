import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/screen/add_todoList.dart';
import 'package:todolist/screen/home.dart';
import 'package:todolist/screen/important_todoList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TodoList',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TodoList(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => TodoList() , transition: Transition.zoom),
        GetPage(name: '/add', page: () => AddTodoListPage(), transition: Transition.zoom),
        GetPage(name: '/point', page: () => ImportantTodoListPage(), transition: Transition.zoom),
      ],
    );
  }
}