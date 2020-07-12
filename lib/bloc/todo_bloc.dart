import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/todo_class.dart';
import 'package:todoapp/repository/repository.dart';
import 'package:equatable/equatable.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<ToDoEvent, TodoState> {
  final Repository todoRepository;
  TodoBloc(this.todoRepository) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(ToDoEvent event) async* {
    yield TodoLoading();
    if (event is GetTodo) {
      try {
        final data = await todoRepository.getToDoData();
        yield TodoLoaded(data);
      } on NetworkError {
        yield TodoError("Couldn't fetch todo. Is the device online?");
      }
    } else if (event is GetTodoDetails) {
      try {
        var _dbHelper = todoRepository.getDatabase;
        await insertOrUpdateTodo(_dbHelper, event.todo);
        yield TodoDetails();
      } on NetworkError {
        yield TodoError("Couldn't fetch todo. Is the device online?");
      }
    } else if (event is SaveTodoDetails) {
      try {
        await todoRepository.getDatabase.insertToDo(event.todo);
        final data = await todoRepository.getToDoData();
        yield TodoLoaded(data);
      } on NetworkError {
        yield TodoError("Couldn't fetch todo. Is the device online?");
      }
    }
  }

  Future<void> insertOrUpdateTodo(var _dbHelper, ToDo toDo) async {
    if (await _dbHelper.checkIfTodoExistsInDB(toDo.id)) {
      var temp = await _dbHelper.getToDo(toDo.id);
      toDo.details = temp.details;
    } else {
      await _dbHelper.insertToDo(toDo);
    }
  }
}
