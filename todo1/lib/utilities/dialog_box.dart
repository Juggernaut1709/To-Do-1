import 'package:flutter/material.dart';
import 'package:todo1/utilities/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(225, 238, 231, 225),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Buttons(
                    text: 'SAVE',
                    onPressed: onSave
                  ),
                  Buttons(
                    text: 'CANCEL',
                    onPressed: onCancel
                  )
                /*TextButton(
                  onPressed: (){},
                  child: Text('SAVE',
                    style: TextStyle(
                      color: Color.fromARGB(255, 129, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                TextButton(
                  onPressed: (){},
                  child: Text('CANCEL',
                    style: TextStyle(
                      color: Color.fromARGB(255, 129, 0, 0),
                      fontWeight: FontWeight.bold,
                    )
                  )
                )*/  
              ],
            )
          ],
        ),
      ),
    );
  }
}