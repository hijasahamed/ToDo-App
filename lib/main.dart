import 'package:flutter/material.dart';
import 'package:todo_app/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const  Color.fromARGB(255, 175, 19, 19)), 
      ),
      home: const TodoList(),
    );
  }
}
