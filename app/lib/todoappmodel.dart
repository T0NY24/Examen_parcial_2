class Todo {
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  set setDescription(String newDescription) {
    description = newDescription;
  }
}

class TodoAppModel {
  final List<Todo> todos = [];

  // Puedes agregar más lógica relacionada con el modelo aquí si es necesario.
  // Por ejemplo, métodos para agregar, editar o eliminar tareas.
}
