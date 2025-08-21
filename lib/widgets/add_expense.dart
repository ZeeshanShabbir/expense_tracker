import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _showDatePickerMondal() async {
    final lastDate = DateTime.now();
    final firstDate = DateTime(lastDate.year - 1, lastDate.month, lastDate.day);
    var userSelectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      selectedDate = userSelectedDate;
    });
  }

  final formatter = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _costController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(label: Text("Cost")),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      selectedDate == null
                          ? "Select Date"
                          : formatter.format(selectedDate!),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: _showDatePickerMondal,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Clear"),
              ),
              Spacer(),
              OutlinedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_costController.text);
                },
                child: Text("Save Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
