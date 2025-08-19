import 'package:expense_tracker_v2/model/expense.dart';
import 'package:expense_tracker_v2/widgets/add_expense.dart';
import 'package:expense_tracker_v2/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expenses = [
    Expense(
      title: "Flutter Course",
      amount: 9.99,
      category: Category.work,
      dateTime: DateTime.now(),
    ),
    Expense(
      title: "Food",
      amount: 19.99,
      category: Category.food,
      dateTime: DateTime.now(),
    ),
    Expense(
      title: "Movie",
      amount: 9.99,
      category: Category.leisure,
      dateTime: DateTime.now(),
    ),
    Expense(
      title: "Traveling",
      amount: 99.99,
      category: Category.travel,
      dateTime: DateTime.now(),
    ),
  ];

  _showAddExpenseMondal() {
    showModalBottomSheet(context: context, builder: (ctx) => AddExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense tracker App"),
        actions: [
          IconButton(onPressed: _showAddExpenseMondal, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text("data"),
          Expanded(child: ExpensesList(expenses)),
        ],
      ),
    );
  }
}
