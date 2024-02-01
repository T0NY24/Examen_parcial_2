import 'package:flutter/material.dart';
import 'todoappmodel.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                Checkbox(
                  value: todos[index].isCompleted,
                  onChanged: (value) {
                    setState(() {
                      todos[index].isCompleted = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    todos[index].title,
                    style: TextStyle(
                      decoration: todos[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Text(todos[index].description),
            onTap: () {
              _editTodo(index);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  todos.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodo() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _titleController = TextEditingController();
        TextEditingController _descriptionController = TextEditingController();

        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos.add(Todo(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editTodo(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _titleController =
            TextEditingController(text: todos[index].title);
        TextEditingController _descriptionController =
            TextEditingController(text: todos[index].description);

        return AlertDialog(
          title: Text('Edit Todo'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todos[index].title = _titleController.text;
                  todos[index].description = _descriptionController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      }, // Agrega este paréntesis
    );
  }
}
