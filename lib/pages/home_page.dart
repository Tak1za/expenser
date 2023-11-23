import 'package:expenser/pages/modify_expense.dart';
import 'package:expenser/provider/expense.dart';
import 'package:expenser/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final _locale = "en_IN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.outlined(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ModifyExpense(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Spent this week",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Consumer<ExpenseProvider>(
                    builder: (context, expenseProvider, _) {
                      return Text(
                        NumberFormat.currency(
                          locale: _locale,
                          symbol:
                              "${NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol} ",
                          decimalDigits: 0,
                        ).format(
                          expenseProvider.totalSpent,
                        ),
                        style: Theme.of(context).textTheme.displayLarge,
                      );
                    },
                  ),
                ],
              ),
            ),
            const ExpenseList(),
          ],
        ),
      ),
    );
  }
}
