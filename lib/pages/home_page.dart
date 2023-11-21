import 'package:expenser/pages/add_expense.dart';
import 'package:expenser/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                          builder: (context) => AddExpense(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onPrimary,
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    NumberFormat.currency(
                      locale: "en_IN",
                      symbol: "₹ ",
                      decimalDigits: 0,
                    ).format(2500),
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            ExpenseList(),
          ],
        ),
      ),
    );
  }
}
