class Expense {
  DateTime timestamp;
  String category;
  String description;
  double amount;

  Expense({
    required this.timestamp,
    required this.category,
    required this.description,
    required this.amount,
  });
}