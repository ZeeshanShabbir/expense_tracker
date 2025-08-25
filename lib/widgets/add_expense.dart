import 'package:expense_tracker_v2/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onNewExpense});

  final void Function(Expense expense) onNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _submitNewExpense() {
    double? amount = double.tryParse(_costController.text);
    var title = _titleController.text.trim();

    if (amount == null || title.isEmpty || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
            'Please make sure a valid title amount, data and category is entered',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onNewExpense(
      Expense(
        title: title,
        amount: amount,
        category: _selectedCategory,
        dateTime: selectedDate!,
      ),
    );
    Navigator.pop(context);
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
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (valuse) {
                  if (valuse == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory == valuse;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Clear"),
              ),
              Spacer(),
              OutlinedButton(
                onPressed: () {
                  _submitNewExpense();
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
