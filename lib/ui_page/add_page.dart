import 'package:bloc_todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/bloc/todo_event.dart';
import 'package:bloc_todo/database/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddPage extends StatelessWidget
{
  int sno;
  String title,desc;
  int completed;
  bool isupdate;
  AddPage({this.sno=0,this.title="",this.desc="",this.completed=0,this.isupdate=false});
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
         if(isupdate)
           {
            titleController.text=title;
            descController.text=desc;
           }
      return Scaffold(backgroundColor: Colors.grey,
        appBar: AppBar(title: Text(isupdate ?"Update Your Todo's" :"Add Your Todo's",
          style: TextStyle(fontSize: 25,color: Colors.black),),
          toolbarHeight: 80,

          centerTitle: true,backgroundColor: Colors.grey),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 400,height: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white60),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(controller: titleController,maxLines: 5,
                    decoration: InputDecoration(focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,
                        hintText: "Add Title....",hintStyle: TextStyle(fontSize: 20)),
                      style: TextStyle(fontSize: 20,color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
              width: 400,height: 300,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white60),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller: descController,maxLines: null,
                  decoration: InputDecoration(focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,
                      hintText: "Add Description....",hintStyle: TextStyle(fontSize: 20)),
                  style: TextStyle(fontSize: 20,color: Colors.black),
                ),
              ),
            ),
                SizedBox(height: 25,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: ()
                  {
                    if(isupdate && titleController.text.isNotEmpty&& descController.text.isNotEmpty)
                      {
                        context.read<TodoBloc>().add(UpdateTodo(updateTodo: TodoModel(title: titleController.text,
                            desc: descController.text, completed: completed,created_at: DateTime.now().microsecondsSinceEpoch.toString()), sno: sno));
                      }
                    else{
                      context.read<TodoBloc>().add(AddTodo(newTodo: TodoModel(title: titleController.text,
                          desc: descController.text, completed: completed,created_at: DateTime.now().microsecondsSinceEpoch.toString())));
                    }
                    Navigator.pop(context);

                  }, child: Text(isupdate?"Save":"Add Todo",style: TextStyle(fontSize: 20,color: Colors.green),)),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel",style: TextStyle(fontSize: 20,color: Colors.red),)),
                ],
                )
              ],
            ),
          ),
        ) ,
      );
  }

}