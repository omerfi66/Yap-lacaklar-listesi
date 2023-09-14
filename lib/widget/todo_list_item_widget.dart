import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_yeniapp/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  /* final TodoModel item; */
  const TodoListItemWidget({
    Key? key,
    /*  required this.item */
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textFocusNode;
  late TextEditingController _textEditingController;
  bool _hasFocus = false;
  

  @override
  void initState() {
    super.initState();
    _textFocusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currenntTodoProvider);
    return Focus(
      onFocusChange: (isFocused) => {
        if (!isFocused)
          {
            setState(() {
              _hasFocus = false;
            }),
            ref.read(todoListProvider.notifier).edit(
                id: currentTodoItem.id,
                newDesciripiton: _textEditingController.text)
          }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
          });
          _textFocusNode.requestFocus();
          _textEditingController.text = currentTodoItem.description;
        },
        leading: Checkbox(
            value: currentTodoItem.complated,
            onChanged: (value) {
              ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
            }),
        title: _hasFocus
            ? TextField(
                controller: _textEditingController,
                focusNode: _textFocusNode,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}



/* 
class TodoListItemWidget extends ConsumerWidget {
  final TodoModel item;
  const TodoListItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return ListTile(
      leading: Checkbox(
          value: item.complated,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(item.id);
          }),
      title: Text(item.description),
    );
  }
}
 */