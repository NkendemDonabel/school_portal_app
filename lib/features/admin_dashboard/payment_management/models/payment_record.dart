/// Model class representing a payment record in the system
/// Contains information about a student's payment transaction
class PaymentRecord {
  final String id;
  final String studentId;
  final String studentName;
  final double amount;
  final DateTime paymentDate;
  final PaymentStatus status;
  final String? transactionId;
  final String? paymentMethod;

  PaymentRecord({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.amount,
    required this.paymentDate,
    required this.status,
    this.transactionId,
    this.paymentMethod,
  });

  /// Convert payment record to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'studentName': studentName,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
      'status': status.toString().split('.').last,
      'transactionId': transactionId,
      'paymentMethod': paymentMethod,
    };
  }

  /// Create payment record from JSON
  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      studentName: json['studentName'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
      ),
      transactionId: json['transactionId'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
    );
  }

  /// Create a copy with updated fields
  PaymentRecord copyWith({
    String? id,
    String? studentId,
    String? studentName,
    double? amount,
    DateTime? paymentDate,
    PaymentStatus? status,
    String? transactionId,
    String? paymentMethod,
  }) {
    return PaymentRecord(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  /// Check if payment is overdue (pending and past due date)
  bool isOverdue(DateTime deadline) {
    return status == PaymentStatus.pending &&
           DateTime.now().isAfter(deadline);
  }
}

/// Enum representing the different payment statuses
enum PaymentStatus {
  paid,
  pending,
  failed,
}

/// Extension to get user-friendly display names and colors
extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.failed:
        return 'Failed';
    }
  }

  /// Get color associated with payment status
  int get colorValue {
    switch (this) {
      case PaymentStatus.paid:
        return 0xFF4CAF50; // Green
      case PaymentStatus.pending:
        return 0xFFFF9800; // Orange
      case PaymentStatus.failed:
        return 0xFFF44336; // Red
    }
  }
}

