import 'package:expenser/db/db.dart';
import 'package:expenser/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  double _totalSpent = 0;
  final _db = DB();

  List<Expense> get expenses => _expenses;
  double get totalSpent => _totalSpent;

  Future<void> expenditure() async {
    _totalSpent = await _db.totalSpent();
  }

  Future<void> fetchExpenses() async {
    _expenses = await _db.getExpenses();
  }

  Future<void> createExpense(Expense expense) async {
    await _db.insertExpense(expense);
    notifyListeners();
  }

  Future<void> removeExpense(Expense expense) async {
    await _db.deleteExpense(expense);
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    _db.updateExpense(expense);
    notifyListeners();
  }
}
