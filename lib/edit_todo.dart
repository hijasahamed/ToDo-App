import 'package:flutter/material.dart';
import 'package:todo_app/functions.dart';

class Edittodo extends StatefulWidget {
   Edittodo({super.key,required this.tododetails});
  dynamic tododetails;
  @override
  State<Edittodo> createState() => _EdittodoState();
}

class _EdittodoState extends State<Edittodo> {
  @override
  void initState() {
    editedtitlecontroller.text=widget.tododetails['title'];
    editeddescriptioncontroller.text=widget.tododetails['description'];
    super.initState();
  }
  TextEditingController editedtitlecontroller = TextEditingController();
  TextEditingController editeddescriptioncontroller = TextEditingController();
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
        title: const Text('EDIT TODO',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
        backgroundColor:const  Color.fromARGB(255, 35, 37, 49),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: editedtitlecontroller,
            maxLines: 1,
              textCapitalization: TextCapitalization.words,
              style:const TextStyle(color: Colors.white),
              decoration:const InputDecoration(label: Text('Title',)),
          ),
          TextFormField(
            controller: editeddescriptioncontroller,
            maxLines: 1,
              textCapitalization: TextCapitalization.words,
              style:const TextStyle(color: Colors.white),
              decoration:const InputDecoration(label: Text('Title',)),
          ),
          const SizedBox(height: 100,),
          ElevatedButton(
            onPressed: (){
              putdata(editedtitlecontroller.text, editeddescriptioncontroller.text, widget.tododetails['_id'].toString(), context);
            },
            style: ElevatedButton.styleFrom(
              fixedSize:const Size(10, 10) 
            ), 
            child: const Text('Submit')
          )
        ],
      ),
    );
  }
}