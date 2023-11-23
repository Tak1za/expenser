import 'package:expenser/db/db.dart';
import 'package:expenser/models/expense.dart';
import 'package:expenser/repository/expense.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  final _expenseRepository = ExpenseRepository(DB());
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;
  double get totalSpent => _expenseRepository.totalSpent();

  void fetchExpenses() {
    _expenses = _expenseRepository.getAll();
  }

  void createExpense(Expense expense) {
    _expenseRepository.insert(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _expenseRepository.remove(expense);
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    _expenseRepository.update(expense);
    notifyListeners();
  }
}
