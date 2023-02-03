import 'package:flutter/material.dart';
import 'package:my_todo/component/dilog_box.dart';
import 'package:my_todo/component/todo_til.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List<Task> todolist = [];

  @override
  void initState() {
    super.initState();
    loadTodoList();
  }

  void loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final todolistTitles = prefs.getStringList('todolist') ?? [];
    setState(() {
      todolist = todolistTitles
          .map((title) => Task(title: title, isDone: false))
          .toList();
    });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todolist[index] = todolist[index];
    });
  }

  Future<void> saveTodo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'todolist', todolist.map((task) => task.title).toList());

    setState(() {
      todolist.add(Task(title: _controller.text, isDone: false));

      _controller.clear();
    });

    Navigator.of(context).pop();
  }

  void creatNewTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return DilogBox(
            controller: _controller,
            onSave: saveTodo,
            onCancel: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  void deleted(int index) async {
    setState(() {
      todolist.removeAt(index);
    }); 
    final pref = await SharedPreferences.getInstance();

    pref.remove( 'todolist');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TO DO'),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[200],
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            todoname: todolist[index].title,
            todoComplet: todolist[index].isDone,
            onChanged: (value) => checkBoxChanged(Task().isDone, index),
            onDelet: (context) => deleted(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: creatNewTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
