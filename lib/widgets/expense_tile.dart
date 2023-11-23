import 'package:expenser/models/expense.dart';
import 'package:expenser/pages/modify_expense.dart';
import 'package:expenser/provider/expense.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final _locale = "en_IN";

  const ExpenseTile({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showBarModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.background,
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Edit'),
              leading: const Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ModifyExpense(
                      expenseToEdit: expense,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Delete'),
              leading: const Icon(Icons.delete),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Expense'),
                    content: const Text(
                        'Are you sure you want to delete this expense?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<ExpenseProvider>(context, listen: false)
                              .removeExpense(expense);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'OK',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
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
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.3,
                      ),
                      child: Text(
                        expense.category,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    expense.description != ""
                        ? Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.4,
                            ),
                            child: Text(
                              expense.description,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.3,
              ),
              child: Text(
                NumberFormat.currency(
                  locale: "en_IN",
                  symbol:
                      "${NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol} ",
                  decimalDigits: 0,
                ).format(expense.amount),
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
