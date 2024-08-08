import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase{

  List toDoList = [];

  final _mybox = Hive.box('myBox');

  void CreateInitialData(){
    toDoList = [
      ['Task 1',false],
      ['Task 2',false],
    ];
  }

  void LoadData(){
    toDoList = _mybox.get('TODOLIST');
  }

  void UpdataData(){
    _mybox.put('TODOLIST', toDoList);
  }

}