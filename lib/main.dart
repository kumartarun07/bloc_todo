import 'package:bloc_todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/database/dbhelper_page.dart';
import 'package:bloc_todo/ui_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main()
{
  runApp(BlocProvider(create: (context)=>TodoBloc(dbHelper: DbHelper.getInstance()),child: MyApp(),));
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
   return MaterialApp(
     home: HomePage(),
   );
  }

}