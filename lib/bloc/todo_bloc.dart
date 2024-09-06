import 'package:bloc_todo/bloc/todo_event.dart';
import 'package:bloc_todo/bloc/todo_state.dart';
import 'package:bloc_todo/database/dbhelper_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>
{
  DbHelper dbHelper;
  TodoBloc({required this.dbHelper} ) : super(InitialState())
  {
    on<AddTodo>((event,emit) async {
      emit(LoadingState());
      bool check = await dbHelper.addTodo(addnote: event.newTodo);
      if(check)
        {
          var allTodo = await dbHelper.fetchTodo();
          emit(SuccessfulState(mtodo: allTodo));
        }
      else
        {
          emit(FailureState(error: "Not Todo Added"));
        }
    });

    on<UpdateTodo>((event,emit) async{
      emit(LoadingState());
      bool check = await dbHelper.updateTodo(updateTodo: event.updateTodo, sno: event.sno);
      if(check)
        {
          var allTodo = await dbHelper.fetchTodo();
          emit(SuccessfulState(mtodo: allTodo));
        }
      else{
        emit(FailureState(error: "No Todo Updated"));
      }
    });

    on<DeleteTodo>((event,emit)async{
      emit(LoadingState());
      bool check = await dbHelper.deleteTodo(sno: event.sno);
      if(check)
        {
          var allTodo = await dbHelper.fetchTodo();
          emit(SuccessfulState(mtodo: allTodo));
        }
      else
        {
          emit(FailureState(error: "No Deleted Todo"));
        }
    });

    on<GetInitialTodo>((event,emit)async{
      var allTodo = await dbHelper.fetchTodo();
      emit(SuccessfulState(mtodo: allTodo));
    });
  }
}