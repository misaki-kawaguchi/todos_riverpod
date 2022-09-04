import 'package:flutter/material.dart';
import 'package:todos_riverpod/models/todo.dart';
import 'package:todos_riverpod/ui/components/todo_item.dart';
import 'package:todos_riverpod/ui/components/todo_title.dart';
import 'package:todos_riverpod/ui/components/toolbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final addTodoKey = UniqueKey();
  final newTodoController = TextEditingController();
  final todoList = [
    const Todo(id: 'todo-0', description: 'hi'),
    const Todo(id: 'todo-1', description: 'hello'),
    const Todo(id: 'todo-2', description: 'bonjour'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(todoList[index].id),
                  onDismissed: (_) {},
                  child: TodoItem(
                    description: todoList[index].description,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
