import 'package:bloc_todo/bloc/todo_bloc.dart';
import 'package:bloc_todo/bloc/todo_event.dart';
import 'package:bloc_todo/bloc/todo_state.dart';
import 'package:bloc_todo/database/todo_model.dart';
import 'package:bloc_todo/ui_page/add_page.dart';
import 'package:bloc_todo/ui_page/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget
{
  DateFormat mformate = DateFormat.yMMMd();
  @override
  Widget build(BuildContext context)
  {
    context.read<TodoBloc>().add(GetInitialTodo());
    return Scaffold(backgroundColor: Colors.grey,
      appBar: AppBar(backgroundColor: Colors.grey,title: Text("My Todo's App",
        style: TextStyle(fontSize: 25,color: Colors.black),),centerTitle: true,),
      body: BlocBuilder<TodoBloc,TodoState>(builder: (_,state) {
        if(state is LoadingState)
          {
           return Center(child: CircularProgressIndicator(),);
          }
        if(state is FailureState)
          {
            return Center(child: Text("Error: ${state.error}"),);
          }
        if(state is SuccessfulState)
          {
             return state.mtodo.isNotEmpty ? ListView.builder(
                 itemCount: state.mtodo.length,
                 itemBuilder: (_, index) {
               return Stack(
                 children: [
                   Container(width: double.infinity,height: 70,
                     child: CheckboxListTile(
                       controlAffinity: ListTileControlAffinity.leading,
                         value:state.mtodo[index].completed==1,
                         onChanged:(value){
                       var update = TodoModel(
                         created_at: state.mtodo[index].created_at,
                           sno: state.mtodo[index].sno,
                           title: state.mtodo[index].title, desc: state.mtodo[index].desc,
                           completed: value! ? 1: 0 );
                       context.read<TodoBloc>().add(UpdateTodo(updateTodo: update, sno: state.mtodo[index].sno!));
                           },
                       title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("${state.mtodo[index].title}",style: TextStyle(fontSize: 20,color: Colors.black),),
                           Text("${mformate.format(DateTime.fromMicrosecondsSinceEpoch(int.parse(state.mtodo[index].created_at)))}"),
                         ],
                       ),
                       subtitle: Text("${state.mtodo[index].desc}",style: TextStyle(fontSize: 20,color: Colors.black),overflow:TextOverflow.ellipsis,),

                         ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 25),
                     child: Row(mainAxisAlignment: MainAxisAlignment.end,

                       children: [
                         IconButton(onPressed: ()
                         {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPage(isupdate: true,
                           title: state.mtodo[index].title,desc: state.mtodo[index].desc,
                             sno: state.mtodo[index].sno!,
                           )));

                         }, icon: Icon(Icons.edit,size: 30,)),
                         IconButton(onPressed: (){
                           context.read<TodoBloc>().add(DeleteTodo(sno: state.mtodo[index].sno!));
                         }, icon: Icon(Icons.delete,size: 30,color: Colors.red,))
                       ],
                     ),
                   ),

                 ],
               );
             }):
             Center(child: Text("No Todo Found",style: TextStyle(fontSize: 20,color: Colors.black),),);
          }
        return Container();
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPage()));
      },
        child: Text("+",style: TextStyle(fontSize: 30,color: Colors.black),),),
    );
  }

}