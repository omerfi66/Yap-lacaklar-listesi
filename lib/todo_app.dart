import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_yeniapp/providers/all_providers.dart';
import 'package:flutter_todo_yeniapp/widget/todo_list_item_widget.dart';
import 'package:flutter_todo_yeniapp/widget/toolbar_widget.dart';
import 'package:flutter_todo_yeniapp/widget/title_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: 'Neler yapacaksın bugün..?'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          allTodos.length == 0
              ? const Center(
                  child: Text(
                  "'Bu koşula uygun herhangi bir görev yok :)",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blueGrey),
                ))
              : SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currenntTodoProvider.overrideWithValue(allTodos[i])
                ], child: const TodoListItemWidget())),
          
        ],
      ),
    );
  }
}
