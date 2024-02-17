import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Add data
postdata(titlecontroller, descriptioncontroller, context) async {
  final titledata = titlecontroller.text;
  final discriptiondata = descriptioncontroller.text;
  final body = {
    "title": titledata,
    "description": discriptiondata,
    "is_completed": false
  };
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode == 201) {
    getdata();
    titlecontroller.text = '';
    descriptioncontroller.text = '';
    Navigator.of(context).pop();
    snackbarmessage('Creation Success', context);
  } else {
    snackbarmessage('Creation Failed', context);
  }
}

// fetch the data
ValueNotifier<List> apinotifier= ValueNotifier([]);

getdata() async {
  const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List<dynamic>;
    apinotifier.value.clear();
    apinotifier.value.addAll(result);
    apinotifier.notifyListeners();
  }
}

// delete the data
delete(String id, context) async {
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.delete(uri);
  if (response.statusCode != 404) {
    getdata();
    Navigator.of(context).pop();
    snackbarmessage('Deleted', context);
  } else {
    snackbarmessage('Failed to Delete', context);
  }
}

deletealertdialogue(context, id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('You want to delete?'),
          actions: [
            TextButton(
                onPressed: () {
                  delete(id, context);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}

// edit data
putdata(String title,String description,String id,context)async{
  final body = {
    "title": title,
    "description": description,
    "is_completed": false
  };
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.put(
    uri,
    body: jsonEncode(body),
    headers: {'Content-Type': 'application/json'},
  );
  if(response.statusCode != 404){
    getdata();
    Navigator.of(context).pop();
    snackbarmessage('Submitted', context);
  }
  else{
    snackbarmessage('Not Submitted', context);
  }
}



// snackbar messages
void snackbarmessage(String message, context) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
