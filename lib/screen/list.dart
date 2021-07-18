import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index){
      return Center(child: _toDo());
      }
    );
  }

  Widget _toDo() {
    return ListTile(
      leading: Icon(
        Icons.star,
        color: Colors.yellowAccent[400],
      ),
      title: Text(
        'go Shopping',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
      ),
      subtitle: Text(
        'MM DD, YYYY'
      ),
      trailing: Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}