class Expense {
  String id;
  DateTime timestamp;
  String category;
  String modeOfPayment;
  String description;
  double amount;

  Expense({
    required this.id,
    required this.timestamp,
    required this.category,
    required this.modeOfPayment,
    required this.description,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'category': category,
      'modeOfPayment': modeOfPayment,
      'description': description,
      'amount': amount
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      timestamp: DateTime.parse(map['timestamp']),
      category: map['category'],
      modeOfPayment: map['modeOfPayment'],
      description: map['description'],
      amount: map['amount'],
    );
  }
}
