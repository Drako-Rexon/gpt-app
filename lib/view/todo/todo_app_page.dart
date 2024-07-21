import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gemini_app/models/todo_model.dart';
import 'package:gemini_app/redirecting_page.dart';
import 'package:gemini_app/services/firebase_database_services.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final DBServices _dbServices = DBServices();
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: () async {
          return showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  title: const Text('Enter your To-Do'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _todoController,
                        decoration: InputDecoration(
                          labelText: 'Enter your text here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _dbServices.addTodo(TodoModel(
                            task: _todoController.text,
                            phoneNumber: "phoneNumber",
                            isDone: false,
                            createdOn: Timestamp.now(),
                            updatedOn: Timestamp.now()));
                        _todoController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('TODO'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: _dbServices.getTodos(),
              builder: (context, snapshot) {
                List todos = snapshot.data?.docs ?? [];
                if (todos.isEmpty) {
                  return const Center(
                    child: Text('add a note'),
                  );
                }
                log(snapshot.data!.docs.toString());
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    TodoModel todo = todos[index].data();
                    String todoId = todos[index].id;
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        onLongPress: () async {
                          _dbServices.deleteTodo(todoId);
                        },
                        title: Text(todo.task),
                        subtitle: Text(DateFormat('dd-MM-yyyy h:mm a')
                            .format(todo.updatedOn.toDate())),
                        trailing: Checkbox(
                          value: todo.isDone,
                          onChanged: (value) {
                            TodoModel updatedTodo = todo.copyWith(
                                isDone: !todo.isDone,
                                updatedOn: Timestamp.now());
                            _dbServices.updateTodo(todoId, updatedTodo);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
