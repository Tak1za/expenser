import 'package:expenser/models/expense.dart';
import 'package:expenser/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({super.key});

  static DateTime currentTime = DateTime.now();
  final dataToRender = [
    Expense(
      timestamp: currentTime.subtract(const Duration(days: 4)),
      category: "Pets",
      description: "Treats",
      amount: 520,
    ),
    Expense(
      timestamp: currentTime.subtract(const Duration(days: 3)),
      category: "Snacks",
      description: "",
      amount: 340,
    ),
    Expense(
      timestamp: currentTime.subtract(const Duration(days: 3)),
      category: "Coffee",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      timestamp: currentTime.subtract(const Duration(days: 2)),
      category: "Gifts",
      description: "Sanyam's Birthday",
      amount: 1250,
    ),
    Expense(
      timestamp: currentTime.subtract(const Duration(days: 1)),
      category: "Coffee",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      timestamp: currentTime,
      category: "Dinner",
      description: "Call me Chow",
      amount: 270,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GroupedListView(
        shrinkWrap: true,
        elements: dataToRender,
        groupBy: (element) => element.timestamp,
        groupComparator: (value1, value2) => value2.compareTo(value1),
        order: GroupedListOrder.ASC,
        groupSeparatorBuilder: (DateTime value) => Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            value.day == DateTime.now().day
                ? "Today"
                : value.day ==
                        DateTime.now().subtract(const Duration(days: 1)).day
                    ? "Yesterday"
                    : DateFormat.yMMMEd('en_US').format(value),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        itemBuilder: (c, element) {
          return ExpenseTile(expense: element);
        },
      ),
    );
  }
}
