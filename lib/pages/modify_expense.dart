import 'package:expenser/models/expense.dart';
import 'package:expenser/utils/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class ModifyExpense extends StatefulWidget {
  final Function? addExpense;
  final Function? editExpense;
  final Expense? expenseToEdit;

  const ModifyExpense(
      {super.key, this.addExpense, this.editExpense, this.expenseToEdit});

  static const _locale = 'en_IN';

  @override
  State<ModifyExpense> createState() => _ModifyExpenseState();
}

class _ModifyExpenseState extends State<ModifyExpense> {
  final _amountController = TextEditingController();

  final _noteController = TextEditingController();

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(ModifyExpense._locale)
          .format(s != "" ? int.parse(s) : 0);

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: ModifyExpense._locale)
          .currencySymbol;

  static final DateTime _selectedTime = DateTime.now();
  var _selectedDate =
      DateTime(_selectedTime.year, _selectedTime.month, _selectedTime.day);

  var _selectedModeOfPayment = 'Credit Card';

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
                          onPressed: () => showBarModalBottomSheet(
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.category,
                          ),
                          label: Text(
                            'Category',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.addExpense != null) {
                          widget.addExpense!(
                            Expense(
                              id: uuid.v4(),
                              category: "Test",
                              amount: double.parse(
                                  _amountController.text.replaceAll(',', '')),
                              modeOfPayment: _selectedModeOfPayment,
                              description: _noteController.text,
                              timestamp: _selectedDate,
                            ),
                          );
                          Navigator.pop(context);
                        }

                        if (widget.editExpense != null) {
                          widget.editExpense!(
                            Expense(
                              id: widget.expenseToEdit!.id,
                              category: "Test",
                              amount: double.parse(
                                  _amountController.text.replaceAll(',', '')),
                              modeOfPayment: _selectedModeOfPayment,
                              description: _noteController.text,
                              timestamp: _selectedDate,
                            ),
                          );
                          Navigator.pop(context);
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