import 'package:flutter/material.dart';
import 'todoappmodel.dart';

class Todo {
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: _todos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido a To-Do-App',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Image.asset(
                    'assets/logo.jpg', // Reemplaza con la ruta de tu imagen
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            )
          : _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];

        return Card(
          elevation: 3.0,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            title: Text(
              todo.title,
              style: todo.isCompleted
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            subtitle: Text(todo.description),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (checked) => _toggleTodo(index),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editTodo(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeTodoDialog(index),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addTodo() {
    _displayDialog(
      title: 'Agregar Tarea',
      confirmTxt: 'Agregar',
      onConfirm: (title, desc) {
        setState(() {
          _todos.add(Todo(
            title: title,
            description: desc,
          ));
        });
      },
    );
  }

  void _editTodo(int index) {
    final todo = _todos[index];

    _displayDialog(
      title: 'Editar Tarea',
      initialTitle: todo.title,
      initialDesc: todo.description,
      confirmTxt: 'Guardar',
      onConfirm: (title, desc) {
        setState(() {
          todo.title = title;
          todo.description = desc;
        });
      },
    );
  }

  void _removeTodoDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Tarea'),
          content: Text('¿Estás seguro de que deseas eliminar esta tarea?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _removeTodo(index);
                Navigator.pop(context);
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _removeTodo(int index) {
    setState(() => _todos.removeAt(index));
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index].isCompleted = !_todos[index].isCompleted;
    });
  }

  void _displayDialog({
    required String title,
    String? initialTitle,
    String? initialDesc,
    required String confirmTxt,
    required Function(String title, String desc) onConfirm,
  }) {
    final controllerTitle = TextEditingController(text: initialTitle);
    final controllerDesc = TextEditingController(text: initialDesc);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controllerTitle,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: controllerDesc,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final enteredTitle = controllerTitle.text;
                final enteredDesc = controllerDesc.text;
                Navigator.pop(context);
                onConfirm(enteredTitle, enteredDesc);
              },
              child: Text(confirmTxt),
            ),
          ],
        );
      },
    );
  }
}
