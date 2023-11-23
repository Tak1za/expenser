import 'package:expenser/db/db.dart';
import 'package:expenser/models/expense.dart';
import 'package:expenser/repository/expense_interface.dart';

class ExpenseRepository implements IExpenseRepository {
  final DB _db;

  ExpenseRepository(this._db);

  @override
  List<Expense> getAll() {
    var items = _db.list();
    return items;
  }

  @override
  void insert(Expense expense) {
    _db.insert(expense);
  }

  @override
  void remove(Expense expense) {
    _db.remove(expense);
  }

  @override
  void update(Expense expense) {
    _db.update(expense);
  }

  @override
  double totalSpent() {
    return _db.totalSpent();
  }
}
