import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskcomplete;
  final DateTime taskDateTime; // New parameter for date and time
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskname,
    required this.taskcomplete,
    required this.taskDateTime, // Initialize the new parameter
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 120, 22, 15),
              foregroundColor: Color.fromRGBO(213, 235, 216, 1),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color.fromRGBO(128, 175, 129, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: taskcomplete,
                    onChanged: onChanged,
                    activeColor: Color.fromRGBO(26, 83, 25, 1),
                  ),
                  Text(
                    taskname,
                    style: TextStyle(
                      color: Color.fromRGBO(26, 83, 25, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: taskcomplete
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
              Text(
                "${taskDateTime.day}/${taskDateTime.month}/${taskDateTime.year} ${taskDateTime.hour}:${taskDateTime.minute}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(26, 83, 25, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
