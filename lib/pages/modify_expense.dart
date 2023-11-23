import 'package:expenser/models/expense.dart';
import 'package:expenser/provider/expense.dart';
import 'package:expenser/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ModifyExpense extends StatefulWidget {
  final Expense? expenseToEdit;
  final _locale = 'en_IN';

  const ModifyExpense({super.key, this.expenseToEdit});

  @override
  State<ModifyExpense> createState() => _ModifyExpenseState();
}

class _ModifyExpenseState extends State<ModifyExpense> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  var _selectedModeOfPayment = 'Credit Card';
  var _selectedCategory = 'Groceries';
  String _formatNumber(String s) => NumberFormat.decimalPattern(widget._locale)
      .format(s != "" ? int.parse(s) : 0);
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: widget._locale).currencySymbol;
  static final DateTime _selectedTime = DateTime.now();
  var _selectedDate =
      DateTime(_selectedTime.year, _selectedTime.month, _selectedTime.day);

  @override
  void initState() {
    super.initState();
    if (widget.expenseToEdit != null) {
      _amountController.text = NumberFormat.currency(
        locale: "en_IN",
        symbol: "",
        decimalDigits: 0,
      ).format(widget.expenseToEdit!.amount);
      _noteController.text = widget.expenseToEdit!.description.toString();
      _selectedModeOfPayment = widget.expenseToEdit!.modeOfPayment;
      _selectedCategory = widget.expenseToEdit!.category;
      _selectedDate = widget.expenseToEdit!.timestamp;
    }
  }

  static const uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Text(
                      'Expense',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5,
                          ),
                          child: Row(
                            children: [
                              Text(
                                '$_currency ',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.color,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  autofocus: true,
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.color,
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    fontSize: 70,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.color,
                                  ),
                                  onChanged: (string) {
                                    string = _formatNumber(
                                      string.replaceAll(',', ''),
                                    );
                                    _amountController.value = TextEditingValue(
                                      text: string,
                                      selection: TextSelection.collapsed(
                                        offset: string.length,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntrinsicWidth(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: TextField(
                            controller: _noteController,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Add a Note',
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                            ),
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.fontSize,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                setState(() {
                                  _selectedDate = selectedDate;
                                });
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                          label: Text(
                            _selectedDate.isToday
                                ? 'Today'
                                : _selectedDate.isYesterday
                                    ? 'Yesterday'
                                    : DateFormat.yMMMEd('en_US')
                                        .format(_selectedDate),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async => await showBarModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('Credit Card'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedModeOfPayment = 'Credit Card';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Cash'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedModeOfPayment = 'Cash';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Debit Card'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedModeOfPayment = 'Debit Card';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Account'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedModeOfPayment = 'Account';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
                            Icons.attach_money,
                          ),
                          label: Text(
                            _selectedModeOfPayment,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async => await showBarModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: const Text('Groceries'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Groceries';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Snacks'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Snacks';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Food'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Food';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Coffee'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Coffee';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Drinks'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Drinks';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Clothing'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Clothing';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Accessories'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Accessories';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Gifts'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Gifts';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Entertainment'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Entertainment';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Home'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Home';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Tech'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Tech';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Subscriptions'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Subscriptions';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Cab'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Cab';
                                    });
                                  },
                                ),
                                ListTile(
                                  title: const Text('Health'),
                                  leading: const Icon(Icons.numbers),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _selectedCategory = 'Health';
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(
                            Icons.category,
                          ),
                          label: Text(
                            _selectedCategory,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        if (widget.expenseToEdit == null) {
                          // create mode
                          Provider.of<ExpenseProvider>(context, listen: false)
                              .createExpense(
                            Expense(
                              id: uuid.v4(),
                              category: _selectedCategory,
                              amount: double.parse(
                                  _amountController.text.replaceAll(',', '')),
                              modeOfPayment: _selectedModeOfPayment,
                              description: _noteController.text,
                              timestamp: _selectedDate,
                            ),
                          );

                          Navigator.pop(context);
                          _amountController.clear();
                          _noteController.clear();
                        }

                        if (widget.expenseToEdit != null) {
                          // edit mode
                          Provider.of<ExpenseProvider>(context, listen: false)
                              .updateExpense(
                            Expense(
                              id: widget.expenseToEdit!.id,
                              category: _selectedCategory,
                              amount: double.parse(
                                  _amountController.text.replaceAll(',', '')),
                              modeOfPayment: _selectedModeOfPayment,
                              description: _noteController.text,
                              timestamp: _selectedDate,
                            ),
                          );

                          Navigator.pop(context);
                          _amountController.clear();
                          _noteController.clear();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
