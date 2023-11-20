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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                  style: Theme.of(context).iconButtonTheme.style,
                )
              ],
            ),
            SizedBox(
              height: 300,
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
