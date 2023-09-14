import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_yeniapp/models/todo_model.dart';
import 'package:flutter_todo_yeniapp/providers/todo_list_manager.dart';

enum TodoListFilter { all, active, complated }

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.complated:
      return todoList.where((element) => element.complated).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.complated).toList();
  }
});

final unComplatedTodoCount = Provider<int>((ref) {
  final allTOdo = ref.watch(todoListProvider);
  final count = allTOdo.where((element) => !element.complated).length;
  return count;
});
final currenntTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
