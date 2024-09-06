import 'package:bloc_todo/database/todo_model.dart';

abstract class TodoEvent {}
class AddTodo extends TodoEvent{
  TodoModel newTodo;
  AddTodo({required this.newTodo});
}
class UpdateTodo extends TodoEvent{
  TodoModel updateTodo;
  int sno;
  UpdateTodo({required this.updateTodo,required this.sno});
}
class DeleteTodo extends TodoEvent{
  int sno;
  DeleteTodo({required this.sno});
}
class GetInitialTodo extends TodoEvent{}