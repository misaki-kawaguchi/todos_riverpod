import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final todo = ref.watch(currentTodoItem);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
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
                onTap: () {
                  itemFocusNode.requestFocus();
                  textFieldFocusNode.requestFocus();
                },
                leading: Checkbox(
                  value: todo.completed,
                  onChanged: (value) {
                    ref.read(todoListProvider.notifier).toggle(todo.id);
                  },
                ),
                title: itemIsFocused
                    ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
                    : Text(todo.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(() {
    void listener() {
      isFocused.value = node.hasFocus;
    }

    node.addListener(listener);
    return () => node.removeListener(listener);
  }, [node]);

  return isFocused.value;
}