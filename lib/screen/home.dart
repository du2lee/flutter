import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/controller.dart';

class TodoList extends GetView<Controller> {
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
              onPressed: () async {
                controller.goIptPage();
              },
              icon: Icon(Icons.star))
        ],
      ),
      body: Obx(() => controller.getListSize > 0
          ? ListView.builder(
              itemCount: controller.getListSize,
              itemBuilder: (BuildContext context, int index) {
                return plan(index);
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
            ))),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            controller.goAddPage();
          },
          child: Icon(Icons.add)),
    );
  }

  Widget plan(int index) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'edit',
            color: Colors.grey.shade200,
            icon: Icons.edit,
            onTap: () => controller.goEditPage(index),
            closeOnTap: false,
          ),
          IconSlideAction(
            caption: 'delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => controller.delete(index),
          ),
        ],
        child: Obx(() => ListTile(
              leading: IconButton(
                onPressed: () async {
                  controller.pressStar(index);
                },
                icon: controller.iptFlag[index]
                    ? Icon(Icons.star)
                    : Icon(Icons.star_border),
                color: controller.iptFlag[index]
                    ? Colors.yellowAccent[400]
                    : Colors.grey[400],
              ),
              title: Obx(() => Text(controller.getPlan[index].title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              subtitle: Obx(() => Text(controller.getPlan[index].date)),
            )),
      );
}
