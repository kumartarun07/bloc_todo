import 'package:bloc_todo/database/dbhelper_page.dart';

class TodoModel
{
  int? sno;
  String title,desc,created_at;
  int completed=0;
  TodoModel({this.sno,required this.title,required this.desc,required this.completed,required this.created_at});

  factory TodoModel.fromMap(Map<String,dynamic>map)=>TodoModel(
      created_at: map[DbHelper.COLUMN_TODO_CREATED_AT],
      sno: map[DbHelper.COLUMN_TODO_SNO],
      title: map[DbHelper.COLUMN_TODO_TITLE],
      desc: map[DbHelper.COLUMN_TODO_DESC],
      completed: map[DbHelper.COLUMN_TODO_COMPLETED]);

  Map<String,dynamic>tomap() =>{
      DbHelper.COLUMN_TODO_TITLE :title,
      DbHelper.COLUMN_TODO_DESC:desc,
      DbHelper.COLUMN_TODO_COMPLETED:completed,
      DbHelper.COLUMN_TODO_CREATED_AT:created_at
  };
}