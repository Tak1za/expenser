import 'package:expenser/models/expense.dart';
import 'package:expenser/pages/add_expense.dart';
import 'package:expenser/widgets/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const _locale = "en_IN";
  static final DateTime currentTime = DateTime.now();
  static DateTime currentDate =
      DateTime(currentTime.year, currentTime.month, currentTime.day);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dataToRender = [
    Expense(
      timestamp: HomePage.currentDate.subtract(const Duration(days: 4)),
      category: "Pets",
      description: "Treats",
      amount: 520,
    ),
    Expense(
      timestamp: HomePage.currentDate.subtract(const Duration(days: 3)),
      category: "Snacks",
      description: "",
      amount: 340,
    ),
    Expense(
      timestamp: HomePage.currentDate.subtract(const Duration(days: 3)),
      category: "Coffee",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      timestamp: HomePage.currentDate.subtract(const Duration(days: 2)),
      category: "Gifts",
      description: "Sanyam's Birthday",
      amount: 1250,
    ),
    Expense(
      timestamp: HomePage.currentDate.subtract(const Duration(days: 1)),
      category: "Coffee",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      timestamp: HomePage.currentDate,
      category: "Dinner",
      description: "Call me Chow",
      amount: 270,
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      dataToRender.add(expense);
    });
  }

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
                          builder: (context) =>
                              AddExpense(addExpense: addExpense),
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
                      locale: HomePage._locale,
                      symbol:
                          "${NumberFormat.compactSimpleCurrency(locale: HomePage._locale).currencySymbol} ",
                      decimalDigits: 0,
                    ).format(
                      dataToRender.fold(
                        0.0,
                        (value, element) => value + element.amount,
                      ),
                    ),
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            ExpenseList(
              dataToRender: dataToRender,
            ),
          ],
        ),
      ),
    );
  }
}
