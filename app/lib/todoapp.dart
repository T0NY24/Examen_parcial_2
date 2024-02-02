import 'package:flutter/material.dart';
import 'todoappmodel.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: todos.isEmpty
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
          : ListView.builder(
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
          title: Text('Agregar Tarea'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _descriptionController,
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
                setState(() {
                  todos.add(Todo(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: Text('Agregar'),
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
          title: Text('Editar Tarea'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _descriptionController,
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
                setState(() {
                  todos[index].title = _titleController.text;
                  todos[index].description = _descriptionController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
