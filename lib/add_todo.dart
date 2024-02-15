import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController discriptioncontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon:const Icon(Icons.arrow_back,color: Colors.white,)
        ),
        centerTitle: true,
        title: const Text('ADD TODO',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        backgroundColor:const  Color.fromARGB(255, 35, 37, 49),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(             
              children: [
                TextFormField(
                  controller: titlecontroller,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  style:const TextStyle(color: Colors.white),
                  decoration:const InputDecoration(label: Text('Title',)), 
                ),
                TextFormField(
                  controller: discriptioncontroller,
                  maxLines:1,
                  textCapitalization: TextCapitalization.sentences,
                  // keyboardType: TextInputType.multiline,
                  style:const TextStyle(color: Colors.white),
                  decoration:const InputDecoration(label: Text('Description')),
                ),
                const SizedBox(height: 100,),
                ElevatedButton(
                  onPressed: (){
                    submitdata();
                  }, 
                  child: const Text('Submit')
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<void> submitdata()async{
    final titledata=titlecontroller.text;
    final discriptiondata=discriptioncontroller.text;
    final body={
      "title": titledata,
      "description": discriptiondata,
      "is_completed": false
    };
    const url='https://api.nstack.in/v1/todos';
    final uri=Uri.parse(url);
    final response= await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode==201){
      print('Creation Success');
      snackbarmessage('Creation Success');
      titlecontroller.text='';
      discriptioncontroller.text='';     
    }
    else{
      print('Creation Failed');
      snackbarmessage('Creation Failed');
      print(response.body);
    }
  }

  void snackbarmessage(String message){
    final snackbar=SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

}