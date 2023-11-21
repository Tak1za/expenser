import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatelessWidget {
  AddExpense({super.key});

  final _controller = TextEditingController();
  static const _locale = 'en_IN';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(s != "" ? int.parse(s) : 0);
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton.outlined(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                    Text(
                      'Expense',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.5,
                                ),
                                child: IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      Text(
                                        '$_currency ',
                                        style: const TextStyle(
                                          fontSize: 40,
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          autofocus: true,
                                          controller: _controller,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: '0',
                                          ),
                                          style: const TextStyle(
                                            fontSize: 70,
                                          ),
                                          onChanged: (string) {
                                            string = _formatNumber(
                                              string.replaceAll(',', ''),
                                            );
                                            _controller.value =
                                                TextEditingValue(
                                              text: string,
                                              selection:
                                                  TextSelection.collapsed(
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
