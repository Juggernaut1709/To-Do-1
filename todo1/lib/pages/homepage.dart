import 'package:flutter/material.dart';
import 'package:todo1/data/database.dart';
import 'package:todo1/utilities/dialog_box.dart';
import 'package:todo1/utilities/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final _mybox = Hive.box('myBox');

  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();


  @override
  void initState(){
    if(_mybox.get('TODOLIST')==null){
      db.CreateInitialData();
    }
    else{
      db.LoadData();
    }
    super.initState();
  }

  void checkBoxChanged(int a){
    setState(() {
      db.toDoList[a][1] = !db.toDoList[a][1];
    });
    db.UpdataData();
  } 

  void save(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.UpdataData();
  }

  void newTile(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: save,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
  }

  void delete(int a){
    setState(() {
      db.toDoList.removeAt(a);
    });
    db.UpdataData();
  }

 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 23, 23),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 99, 0, 0),
        title: Center(
          child: Text('TO DO',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 238, 238,238)
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: newTile,
        child: Icon(Icons.add,
          size: 30,
          color: Color.fromARGB(255, 57, 62, 70),
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(
            taskname: db.toDoList[index][0],
            taskcomplete: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => delete(index),
          );
        }
      ),
    );
  }
}