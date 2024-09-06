import 'package:bloc_todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/bloc/todo_event.dart';
import 'package:bloc_todo/bloc/todo_state.dart';
import 'package:bloc_todo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget
{
  String title,desc;
  DetailPage({required this.title,required this.desc});
  @override
  Widget build(BuildContext context)
  {
    context.read<TodoBloc>().add(GetInitialTodo());
    return Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(backgroundColor: Colors.grey,title: Text("Your Todo",
        style: TextStyle(fontSize: 25,color: Colors.black),),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(width: 400,height: 100,color: Colors.white70,
              child: Text(title,style: TextStyle(fontSize: 30),),
            ),
            SizedBox(height: 10,),
            Container(width: 400,height: 700,color: Colors.white70,
              child: Text(desc,style: TextStyle(fontSize: 40),),
            ),

          ],

        ),
      ),
    );
  }

}