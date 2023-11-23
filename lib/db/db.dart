import 'package:expenser/models/expense.dart';
import 'package:uuid/uuid.dart';

class DB {
  static final DateTime currentTime = DateTime.now();
  static DateTime currentDate =
      DateTime(currentTime.year, currentTime.month, currentTime.day);
  static const uuid = Uuid();

  final List<Expense> _items = [
    Expense(
      id: uuid.v4(),
      timestamp: currentDate.subtract(const Duration(days: 4)),
      category: "Food",
      modeOfPayment: "Credit Card",
      description: "ITC",
      amount: 520,
    ),
    Expense(
      id: uuid.v4(),
      timestamp: currentDate.subtract(const Duration(days: 3)),
      category: "Snacks",
      modeOfPayment: "Credit Card",
      description: "",
      amount: 340,
    ),
    Expense(
      id: uuid.v4(),
      timestamp: currentDate.subtract(const Duration(days: 3)),
      category: "Coffee",
      modeOfPayment: "Credit Card",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      id: uuid.v4(),
      timestamp: currentDate.subtract(const Duration(days: 2)),
      category: "Gifts",
      modeOfPayment: "Credit Card",
      description: "Sanyam's Birthday",
      amount: 1250,
    ),
    Expense(
      id: uuid.v4(),
      timestamp: currentDate.subtract(const Duration(days: 1)),
      category: "Coffee",
      modeOfPayment: "Cash",
      description: "Starbucks",
      amount: 350,
    ),
    Expense(
      id: uuid.v4(),
      timestamp: currentDate,
      category: "Food",
      modeOfPayment: "Credit Card",
      description: "Call me Chow",
      amount: 270,
    ),
  ];
  static final DB _db = DB._privateConstructor();

  DB._privateConstructor();

  factory DB() {
    return _db;
  }

  void insert(Expense item) {
    _items.add(item);
  }

  void remove(Expense item) {
    _items.removeWhere((element) => element.id == item.id);
  }

  void update(Expense item) {
    final index = _items.indexWhere((element) => element.id == item.id);
    _items[index] = item;
  }

  double totalSpent() {
    return _items.fold(
      0.0,
      (value, element) => value + element.amount,
    );
  }

  List<Expense> list() {
    return _items;
  }
}
