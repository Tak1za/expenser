import 'package:expenser/app_constants.dart';
import 'package:expenser/provider/expense.dart';
import 'package:expenser/utils/date_helper.dart';
import 'package:expenser/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    super.key,
  });

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final expenseProvider =
      Provider.of<ExpenseProvider>(AppConstants.globalNavKey.currentContext!);

  @override
  void initState() {
    expenseProvider.fetchExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ExpenseProvider>(
        builder: (BuildContext context, ExpenseProvider expenseProvider, _) {
          return expenseProvider.expenses.isEmpty
              ? Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Start by adding your expenses",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                )
              : GroupedListView(
                  shrinkWrap: true,
                  elements: expenseProvider.expenses,
                  groupBy: (element) => element.timestamp,
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  order: GroupedListOrder.ASC,
                  groupSeparatorBuilder: (DateTime value) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      value.isToday
                          ? "Today"
                          : value.isYesterday
                              ? "Yesterday"
                              : DateFormat.yMMMEd('en_US').format(value),
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return ExpenseTile(
                      expense: element,
                    );
                  },
                );
        },
      ),
    );
  }
}
