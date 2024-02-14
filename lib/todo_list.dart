import 'package:flutter/material.dart';
import 'package:todo_app/add_todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const Icon(Icons.menu,color: Colors.white,),
        centerTitle: true,
        title: const Text('TODO APP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
        backgroundColor:const  Color.fromARGB(255, 35, 37, 49),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemBuilder: (ctx,index){
              return  Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey[500],),
              );
            },
            separatorBuilder: (ctx,index){
              return const  Divider(color: Colors.transparent,);
            }, 
            itemCount: 10
          ),
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx){
                return const Addtodo();
              }
            )
          );
        },
        label:const Icon(Icons.add),
        elevation: 10,
        backgroundColor: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}