import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todos_riverpod/models/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final currentTodoItem = Provider<Todo>((ref) => throw UnimplementedError());

final todoListProvider = StateNotifierProvider<TodoListViewModel, List<Todo>>((ref) {
  return TodoListViewModel();
});

class TodoListViewModel extends StateNotifier<List<Todo>> {
  TodoListViewModel(): super([]);

  void add(String description) {
    state = [
      // スプレッド演算子（データを結合する）
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }
}
