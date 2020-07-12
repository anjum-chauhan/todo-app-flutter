part of 'todo_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
}

class GetTodo extends ToDoEvent {
  const GetTodo();

  @override
  List<Object> get props => [];
}

class GetTodoDetails extends ToDoEvent {
  final ToDo todo;
  const GetTodoDetails(this.todo);

  @override
  List<Object> get props => [todo.id];
}

class SaveTodoDetails extends ToDoEvent {
  final ToDo todo;
  const SaveTodoDetails(this.todo);

  @override
  List<Object> get props => [todo.id];
}
