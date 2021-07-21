import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/controller.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  void delete(int index) {
    setState(() {
      Get.find<Controller>().getTitle.removeAt(index);
      Get.find<Controller>().getDate.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
        actions: <Widget>[
          //중요한 계획들만
          IconButton(
              onPressed: () {
                Get.toNamed('/point');
              },
              icon: Icon(Icons.star))
        ],
      ),
      body: Get.find<Controller>().getListSize > 0
          ? ListView.builder(
              itemCount: Get.find<Controller>().getListSize,
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'edit',
                      color: Colors.grey.shade200,
                      icon: Icons.edit,
                      onTap: () => {Get.toNamed('/add', arguments: false)},
                      closeOnTap: false,
                    ),
                    IconSlideAction(
                      caption: 'delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => delete(index),
                    ),
                  ],
                  child: ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.yellowAccent[400],
                    ),
                    title: Text(Get.find<Controller>().getTitle[index],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(Get.find<Controller>().getDate[index]),
                  ),
                );
              })
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add your plan',
                  style: TextStyle(color: Colors.grey, fontSize: 40),
                ),
                SizedBox(height: 100)
              ],
            )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            await Get.toNamed('/add', arguments: true);
          },
          child: Icon(Icons.add)),
    );
  }
}
