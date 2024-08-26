import 'package:flutter/material.dart';
import 'package:todo1/utilities/buttons.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dtp;

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final DateTime? selectedDate;
  final DateTime? selectedTime;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.controller,
    required this.selectedDate,
    required this.selectedTime,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(229, 229, 203, 1),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    dtp.DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2100, 12, 31),
                      theme: const dtp.DatePickerTheme(
                        headerColor: Color.fromRGBO(26, 18, 11, 1),
                        backgroundColor: Color.fromRGBO(229, 229, 203, 1),
                        itemStyle: TextStyle(
                          color: Color.fromARGB(255, 60, 42, 33),
                          fontWeight: FontWeight.bold,
                        ),
                        doneStyle: TextStyle(
                          color: Color.fromRGBO(213, 206, 163, 1),
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (date) {
                        Navigator.pop(context, {'selectedDate': date});
                      },
                      currentTime: selectedDate ?? DateTime.now(),
                      locale: dtp.LocaleType.en,
                    );
                  },
                  icon: Icon(Icons.date_range),
                  label: Text(
                    selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Pick Date",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    dtp.DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      theme: const dtp.DatePickerTheme(
                        headerColor: Color.fromRGBO(26, 18, 11, 1),
                        backgroundColor: Color.fromRGBO(229, 229, 203, 1),
                        itemStyle: TextStyle(
                          color: Color.fromARGB(255, 60, 42, 33),
                          fontWeight: FontWeight.bold,
                        ),
                        doneStyle: TextStyle(
                          color: Color.fromRGBO(213, 206, 163, 1),
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (time) {
                        Navigator.pop(context, {'selectedTime': time});
                      },
                      currentTime: selectedTime ?? DateTime.now(),
                      locale: dtp.LocaleType.en,
                    );
                  },
                  icon: Icon(Icons.access_time),
                  label: Text(
                    selectedTime != null
                        ? "${selectedTime!.hour}:${selectedTime!.minute}"
                        : "Pick Time",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Buttons(
                  text: 'SAVE',
                  onPressed: onSave,
                ),
                Buttons(
                  text: 'CANCEL',
                  onPressed: onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
