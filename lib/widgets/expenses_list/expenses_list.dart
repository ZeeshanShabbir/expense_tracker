import 'package:expense_tracker_v2/model/expense.dart';
import 'package:expense_tracker_v2/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, this.onExpenseRemoved, {super.key});

  final List<Expense> expenses;
  final void Function(Expense expense) onExpenseRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => {onExpenseRemoved(expenses[index])},
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
