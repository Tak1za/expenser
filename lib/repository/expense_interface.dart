import 'package:expenser/models/expense.dart';

abstract class IExpenseRepository {
  List<Expense> getAll();
  void insert(Expense expense);
  void remove(Expense expense);
  void update(Expense expense);
  double totalSpent();
}
