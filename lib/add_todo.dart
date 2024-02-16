import 'package:flutter/material.dart';
import 'package:todo_app/functions.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({super.key});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController descriptioncontroller =TextEditingController();
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
                  controller: descriptioncontroller,
                  maxLines:1,
                  textCapitalization: TextCapitalization.sentences,
                  // keyboardType: TextInputType.multiline,
                  style:const TextStyle(color: Colors.white),
                  decoration:const InputDecoration(label: Text('Description')),
                ),
                const SizedBox(height: 100,),
                ElevatedButton(
                  onPressed: (){
                    postdata(titlecontroller,descriptioncontroller,context);
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
}