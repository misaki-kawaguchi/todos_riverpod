import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_riverpod/providers/todolist_provider.dart';
import 'package:todos_riverpod/ui/components/todo_item.dart';
import 'package:todos_riverpod/ui/components/todo_title.dart';
import 'package:todos_riverpod/ui/components/toolbar.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final addTodoKey = UniqueKey();
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TodoTitle(),
              TextField(
                key: addTodoKey,
                controller: newTodoController,
                decoration: const InputDecoration(
                  labelText: 'What needs to be done?',
                ),
                onSubmitted: (value) {
                  ref.read(todoListProvider.notifier).add(value);
                  newTodoController.clear();
                },
              ),
              const SizedBox(height: 42),
              const Toolbar(),
              Container(
                decoration: todos.isNotEmpty ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ): BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(todos[index].id),
                      onDismissed: (_) {},
                      child: ProviderScope(
                        // 値をオーバーライド
                        overrides: [
                          currentTodoItem.overrideWithValue(todos[index]),
                        ],
                        child: TodoItem(
                          description: todos[index].description,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
