import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu,color: Colors.white,),
        centerTitle: true,
        title: const Text('ToDo App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
        backgroundColor:const  Color.fromARGB(255, 35, 37, 49),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blueGrey[500],),
          ),
        )
      )
    );
  }
}