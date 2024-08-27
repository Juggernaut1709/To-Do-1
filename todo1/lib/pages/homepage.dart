import 'package:flutter/material.dart';
import 'package:todo1/data/database.dart';
import 'package:todo1/data/notif.dart';
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
    scheduleNotification(taskDateTime, _controller.text);
    setState(() {
      db.toDoList.add([_controller.text, false, selectDate]);
      _controller.clear();
    });

    db.UpdateData();
    Navigator.of(context).pop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background
    } else if (state == AppLifecycleState.resumed) {
      // App is in foreground
    }
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 54, 120, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 1, 97, 1),
        title: const Center(
            child: Text(
          'TO DO',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(235, 54, 120, 1)),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(24, 1, 97, 1),
        onPressed: newTile,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Color.fromRGBO(235, 54, 120, 1),
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
    );
  }
}
