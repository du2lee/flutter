import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todolist/controller/controller.dart';

class ImportantTodoListPage extends GetView<Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Important plans',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Obx(() => controller.getSetSize > 0
          ?  ListView.builder(
              itemCount: controller.getSetSize,
              itemBuilder: (BuildContext context, int index) {
                return plan(index);
              })
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nothing',
                  style: TextStyle(color: Colors.grey, fontSize: 40),
                ),
                SizedBox(height: 100)
              ],
            ))),
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
            onTap: () => {},
            closeOnTap: false,
          ),
          IconSlideAction(
            caption: 'delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => {},
          ),
        ],
        child: ListTile(
          leading: Icon(
            Icons.star,
            color: Colors.yellowAccent[400],
          ),
          title: Obx(() => Text(controller.getIptPlan[index].title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          subtitle: Obx(() => Text(controller.getIptPlan[index].date)),
        ),
      );
}
