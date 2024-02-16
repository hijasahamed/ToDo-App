import 'package:flutter/material.dart';
import 'package:todo_app/add_todo.dart';
import 'package:todo_app/functions.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List todoitemslist=[];
  @override
  void initState() {
    getdata();
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
            onRefresh: getdata,
            child: ValueListenableBuilder(
              valueListenable: api, 
              builder: (ctx,items,child){
                final values=items.toList();
                if(values.isEmpty){
                  const Center(
                    child: Text('No Data',style: TextStyle(color: Colors.white),),
                  );
                }
                return ListView.builder(
                  itemCount: values.length,
                  itemBuilder: (ctx,index){
                    final data=values[index];
                    return Card(
                      color: Colors.blueGrey[500],
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index+1}'),
                        ),
                        title: Text(data['title']),
                        subtitle: Text(data['description']),
                      ),
                    );
                  }
                );
              }
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

  
  
}