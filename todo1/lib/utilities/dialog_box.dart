import 'package:flutter/material.dart';
import 'package:todo1/utilities/buttons.dart';
import 'package:calendar_view/calendar_view.dart';

class DialogBox extends StatefulWidget {
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
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedTime = widget.selectedTime != null
        ? TimeOfDay(
            hour: widget.selectedTime!.hour,
            minute: widget.selectedTime!.minute)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(214, 239, 216, 1),
      content: SizedBox(
        height: 200,
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                hintText: 'Enter your task',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(128, 175, 129, 1),
                    backgroundColor: const Color.fromRGBO(26, 83, 25, 1),
                  ),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100, 12, 31),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  // ignore: prefer_const_constructors
                  icon: Icon(Icons.date_range),
                  label: Text(
                    _selectedDate != null
                        ? "${_selectedDate!.day}/${_selectedDate!.month}"
                        : "Pick Date",
                  ),
                ),
                const SizedBox(width: 5),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(128, 175, 129, 1),
                    backgroundColor: const Color.fromRGBO(26, 83, 25, 1),
                  ),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _selectedTime = pickedTime;
                      });
                    }
                  },
                  icon: const Icon(Icons.access_time),
                  label: Text(
                    _selectedTime != null
                        ? "${_selectedTime!.hour}:${_selectedTime!.minute}"
                        : "Pick Time",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Buttons(
                  text: 'SAVE',
                  onPressed: widget.onSave,
                ),
                Buttons(
                  text: 'CANCEL',
                  onPressed: widget.onCancel,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
