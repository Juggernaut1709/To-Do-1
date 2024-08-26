import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  final _mybox = Hive.box('myBox2');

  // Create initial data with DateTime included for first-time users
  void CreateInitialData() {
    toDoList = [
      ['Task 1', false, DateTime.now()],
      ['Task 2', false, DateTime.now()],
    ];
  }

  // Load the data from the database
  void LoadData() {
    toDoList = _mybox.get('TODOLIST');
  }

  // Update the database with the current toDoList
  // ignore: non_constant_identifier_names
  void UpdateData() {
    _mybox.put('TODOLIST', toDoList);
  }
}
