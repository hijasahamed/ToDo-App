import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Add data
Future<void> postdata(titlecontroller, descriptioncontroller, context) async {
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
ValueNotifier<List> api = ValueNotifier([]);

Future<void> getdata() async {
  const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = jsonDecode(response.body) as Map;
    final result = json['items'] as List<dynamic>;
    api.value.clear();
    api.value.addAll(result);
    api.notifyListeners();
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

put(){
  
}

void snackbarmessage(String message, context) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
