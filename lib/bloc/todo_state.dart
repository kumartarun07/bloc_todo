import 'package:bloc_todo/database/todo_model.dart';

abstract class TodoState {}
class InitialState extends TodoState{}
class LoadingState extends TodoState{}
class SuccessfulState extends TodoState{
  List<TodoModel>mtodo;
  SuccessfulState({required this.mtodo});
}
class FailureState extends TodoState{
  String error;
  FailureState({required this.error});
}
