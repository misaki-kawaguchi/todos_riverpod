import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_riverpod/providers/todolist_provider.dart';

class Toolbar extends HookConsumerWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allFilterKey = UniqueKey();
    final activeFilterKey = UniqueKey();
    final completedFilterKey = UniqueKey();

    final uncompletedTodosCount = Provider<int>((ref) {
      return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
    });

    return Material(
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${ref.watch(uncompletedTodosCount)} items left',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(Colors.blue)
              ),
              child: const Text('All'),
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: MaterialStateProperty.all(Colors.black)
              ),
              child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: (){},
              style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: MaterialStateProperty.all(Colors.black)
              ),
              child: const Text('Completed'),
            ),
          ),
        ],
      ),
    );
  }
}
