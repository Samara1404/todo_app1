import 'package:flutter/material.dart';
import 'package:todo_app1/model/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isCompleted = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _author = TextEditingController();

  Future <void> addTodo() async {
    final db = FirebaseFirestore.instance;
    final todo = Todo(title: _title.text, description: _description.text, 
    isCompleted: _isCompleted, author: _author.text);
    await db.collection("todos").add(todo.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(hintText: 'Title',
                border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _description,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'description',
                border: OutlineInputBorder()),
              ),
              CheckboxListTile(
                  title: Text('Is Completed'),
                  value: _isCompleted,
                  onChanged: (v) {
                    setState(() {
                      _isCompleted = v ?? false;
                    });
                  }),
              const SizedBox(height: 20),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(hintText: 'the author',
                border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(onPressed: () async {
                if (_formkey.currentState!.validate()) {await addTodo();}
              }, 
              icon: Icon(Icons.publish), label: Text('Add Todo')),
            ],
          ),
        ),
      ),
    );
  }
}