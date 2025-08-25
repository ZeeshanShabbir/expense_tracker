import 'package:expense_tracker_v2/model/expense.dart';
import 'package:expense_tracker_v2/widgets/add_expense.dart';
import 'package:expense_tracker_v2/widgets/chart/chart.dart';
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

  _addANewExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  _showAddExpenseMondal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(onNewExpense: _addANewExpense),
    );
  }

  void _removeExpense(Expense expense) {
    final index = expenses.indexOf(expense);
    setState(() {
      expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense removed"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
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
          Chart(expenses: expenses),
          Expanded(child: ExpensesList(expenses, _removeExpense)),
        ],
      ),
    );
  }
}
