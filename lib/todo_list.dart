import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/add_todo.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List items=[];
  @override
  void initState() {
    fetchTodo();
    super.initState();
  }
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
          child: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.separated(
              itemBuilder: (ctx,index){
                final item=items[index] as Map;
                return  Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey[500],),
                  child: ListTile(
                    leading: CircleAvatar(child: Text('${index+1}')),
                    title: Text(item['title']),
                    subtitle: Text(item['discription']),
                  ),
                );
              },
              separatorBuilder: (ctx,index){
                return const  Divider(color: Colors.transparent,);
              }, 
              itemCount: items.length
            ),
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

  Future<void> fetchTodo()async{
    final url='https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri=Uri.parse(url);
    final response=await http.get(uri);
    if(response.statusCode==200){
      final json=jsonDecode(response.body) as Map;
      final result= json['items'] as List;
      setState(() {
        items=result;
      });
    }
    else{

    }
  }
}