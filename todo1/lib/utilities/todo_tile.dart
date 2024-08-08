import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

late final String taskname;
late final bool taskcomplete;
Function(bool?)? onChanged;
Function(BuildContext)?deleteFunction;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taskcomplete,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:25.0, right:25.0, top:25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: deleteFunction,
              icon: Icons.delete, 
              backgroundColor: Color.fromARGB(255, 120, 22, 15),
              foregroundColor: Colors.grey 
            )
          ]
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromARGB(225, 238, 231, 225),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(value: taskcomplete,
              onChanged: onChanged,
              activeColor: Color.fromARGB(255, 129, 0, 0),
              ),
              Text(taskname,
                style: TextStyle(
                  color: Color.fromARGB(255, 27, 23, 23),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  decoration: taskcomplete ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}