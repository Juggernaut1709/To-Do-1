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
  final _mybox = Hive.box('myBox2');

  final _controller = TextEditingController();
  var selectDate = DateTime.now();
  var selectTime = DateTime.now();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      db.CreateInitialData();
    } else {
      db.LoadData();
    }
    super.initState();
  }

  void checkBoxChanged(int a) {
    setState(() {
      db.toDoList[a][1] = !db.toDoList[a][1];
    });
    db.UpdateData();
  }

  void save() {
    DateTime taskDateTime = selectDate;
    setState(() {
      db.toDoList.add([_controller.text, false, selectDate]);
      _controller.clear();
    });

    db.UpdateData();
    Navigator.of(context).pop();
  }

  void newTile() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          selectedDate: selectDate,
          selectedTime: selectTime,
          onSave: save,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    ).then((result) {
      if (result != null) {
        if (result.containsKey('selectedDate')) {
          selectDate = result['selectedDate'];
        }
        if (result.containsKey('selectedTime')) {
          selectTime = result['selectedTime'];
        }
        // Do something with the selected date and time
      }
    });
  }

  void delete(int a) {
    setState(() {
      db.toDoList.removeAt(a);
    });
    db.UpdateData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(214, 239, 216, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(26, 83, 25, 1),
          title: const Center(
              child: Text(
            'TO DO',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(214, 239, 216, 1)),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(128, 175, 129, 1),
          onPressed: newTile,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Color.fromRGBO(214, 239, 216, 1),
          ),
        ),
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return TodoTile(
                taskname: db.toDoList[index][0],
                taskcomplete: db.toDoList[index][1],
                taskDateTime: db.toDoList[index][2],
                onChanged: (value) => checkBoxChanged(index),
                deleteFunction: (context) => delete(index),
              );
            }),
      ),
    );
  }
}
