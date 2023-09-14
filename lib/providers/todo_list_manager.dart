import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_yeniapp/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);
  void addTodo(String description) {
    var eklenecekTodo =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, eklenecekTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: todo.description,
              complated: !todo.complated)
        else
          todo,
    ];
  }

  void edit({required String id, required String newDesciripiton}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: todo.id,
            description: newDesciripiton,
            complated: todo.complated,
          )
        else
          todo
    ];
  }

  void remove(TodoModel silinecekTodo) {
    state = state.where((element) => element.id != silinecekTodo.id).toList();
  } //where elemanları tek tek gezip verdiğimiz işi yapıyordu

  int onComplatedTodoCount() {
    return state.where((element) => !element.complated).length;
  }
}
