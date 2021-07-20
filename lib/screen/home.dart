import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/screen/add_todoList.dart';
import 'package:todolist/screen/important_todoList.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todoList = [];

  void delete(int index) {
    setState(() {
      todoList.removeAt(index);
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ImportantTodoListPage();
                }));
              },
              icon: Icon(Icons.star))
        ],
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
                child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.yellowAccent[400],
                ),
                title: Text(todoList[index].toString(),
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('MM DD, YYYY'),
              ),
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
                  onTap: () => delete(index),
                ),
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () async {
            var addText = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTodoListPage()),
            );
            if (addText != null) {
              setState(() {
                todoList.add(addText);
              });
            }
          }),
    );
  }
}
