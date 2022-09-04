import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_riverpod/providers/todolist_provider.dart';

class TodoItem extends HookConsumerWidget {
  const TodoItem({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemFocusNode = FocusNode();
    final todo = ref.watch(currentTodoItem);

    return Material(
      color: Colors.white,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {},
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              right: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
              top: BorderSide(
                color: Color(0xFFEEEEEE),
              ),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {},
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (value) {
                    ref.read(todoListProvider.notifier).toggle(todo.id);
                  },
                ),
                title: Text(todo.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
