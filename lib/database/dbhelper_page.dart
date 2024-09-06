import 'dart:core';
import 'dart:io';
import 'package:bloc_todo/database/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper
{
  DbHelper ._();
  static DbHelper getInstance() => DbHelper ._();
  Database? tDB;
  static final String TABLE_TODO ="todo";
  static final String COLUMN_TODO_SNO = "sno";
  static final String COLUMN_TODO_TITLE ="title";
  static final String COLUMN_TODO_DESC = "desc";
  static final String COLUMN_TODO_COMPLETED ="completed";

  Future<Database> getDB()
  async{
    if(tDB!=null)
      {
        return tDB!;
      }
    else
      {
        tDB = await openDB();
        return tDB!;
      }
  }

  Future<Database> openDB()
  async{
    Directory dir = await getApplicationDocumentsDirectory();
    String dbpath = join(dir.path,"todo.db");
    return await openDatabase(dbpath,onCreate: (db,vrsion){
      db.execute("create table $TABLE_TODO ( $COLUMN_TODO_SNO INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$COLUMN_TODO_TITLE TEXT ,$COLUMN_TODO_DESC TEXT , $COLUMN_TODO_COMPLETED INTEGER )");
    },version: 1);
  }

  Future<bool> addTodo({required TodoModel addnote})
  async{
      var tDB = await getDB();
      int rowsEffected = await tDB.insert(TABLE_TODO, addnote.tomap());
      return rowsEffected>0;
  }

  Future<List<TodoModel>> fetchTodo()
  async{
    var tDB = await getDB();
    var Data = await tDB.query(TABLE_TODO);
    List<TodoModel>mtodo = [];
    for(Map<String,dynamic> eachData in Data)
      {
        mtodo.add(TodoModel.fromMap(eachData));
      }
    return mtodo;
  }

  Future<bool>updateTodo({required TodoModel updateTodo,required int sno})
  async{
    var tDB = await getDB();
    int rowsEffected = await tDB.update(TABLE_TODO, updateTodo.tomap(),
        where: "$COLUMN_TODO_SNO=?",whereArgs: ["$sno"]);
      return rowsEffected>0;
  }

  Future<bool>deleteTodo({required int sno})
  async{
    var tDB = await getDB();
    int rowsEffected = await tDB.delete(TABLE_TODO,where: "$COLUMN_TODO_SNO=?",whereArgs: ["$sno"]);
    return rowsEffected>0;
  }

}
