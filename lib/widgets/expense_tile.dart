import 'package:expenser/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.category,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  expense.description != ""
                      ? Text(
                          expense.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      : Container(),
                ],
              ),
            ],
          ),
          Text(
            NumberFormat.currency(
              locale: "en_IN",
              symbol: "₹ ",
              decimalDigits: 0,
            ).format(expense.amount),
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
