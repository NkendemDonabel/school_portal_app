import '../models/payment_record.dart';
import '../models/fee_structure.dart';
import '../models/payment_method.dart';

/// Service class to handle payment-related operations
/// Currently uses dummy data but can be extended to use API calls
class PaymentService {
  /// Get all payment records (dummy data for now)
  static List<PaymentRecord> getAllPaymentRecords() {
    return [
      PaymentRecord(
        id: 'PAY001',
        studentId: '1',
        studentName: 'Emma Johnson',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 15),
        status: PaymentStatus.paid,
        transactionId: 'TXN001',
        paymentMethod: 'Online Banking',
      ),
      PaymentRecord(
        id: 'PAY002',
        studentId: '2',
        studentName: 'Liam Smith',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 20),
        status: PaymentStatus.paid,
        transactionId: 'TXN002',
        paymentMethod: 'Card Payment',
      ),
      PaymentRecord(
        id: 'PAY003',
        studentId: '3',
        studentName: 'Olivia Williams',
        amount: 5000.00,
        paymentDate: DateTime(2026, 3, 1),
        status: PaymentStatus.pending,
        transactionId: null,
        paymentMethod: null,
      ),
      PaymentRecord(
        id: 'PAY004',
        studentId: '4',
        studentName: 'Noah Brown',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 18),
        status: PaymentStatus.paid,
        transactionId: 'TXN003',
        paymentMethod: 'Mobile Money',
      ),
      PaymentRecord(
        id: 'PAY005',
        studentId: '5',
        studentName: 'Ava Jones',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 25),
        status: PaymentStatus.failed,
        transactionId: 'TXN004',
        paymentMethod: 'Card Payment',
      ),
      PaymentRecord(
        id: 'PAY006',
        studentId: '6',
        studentName: 'Ethan Davis',
        amount: 5000.00,
        paymentDate: DateTime(2026, 1, 30),
        status: PaymentStatus.pending,
        transactionId: null,
        paymentMethod: null,
      ),
      PaymentRecord(
        id: 'PAY007',
        studentId: '7',
        studentName: 'Sophia Miller',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 28),
        status: PaymentStatus.paid,
        transactionId: 'TXN005',
        paymentMethod: 'Online Banking',
      ),
      PaymentRecord(
        id: 'PAY008',
        studentId: '8',
        studentName: 'Mason Wilson',
        amount: 5000.00,
        paymentDate: DateTime(2026, 2, 22),
        status: PaymentStatus.failed,
        transactionId: 'TXN006',
        paymentMethod: 'Mobile Money',
      ),
    ];
  }

  /// Get payment summary statistics
  static Map<String, double> getPaymentSummary() {
    final records = getAllPaymentRecords();

    double totalPayments = 0;
    double pendingFees = 0;
    double paidFees = 0;
    double failedPayments = 0;

    for (var record in records) {
      totalPayments += record.amount;

      switch (record.status) {
        case PaymentStatus.paid:
          paidFees += record.amount;
          break;
        case PaymentStatus.pending:
          pendingFees += record.amount;
          break;
        case PaymentStatus.failed:
          failedPayments += record.amount;
          break;
      }
    }

    return {
      'totalPayments': totalPayments,
      'pendingFees': pendingFees,
      'paidFees': paidFees,
      'failedPayments': failedPayments,
    };
  }

  /// Get current fee structure (dummy data)
  static FeeStructure getFeeStructure() {
    return FeeStructure(
      id: 'FEE001',
      academicYear: '2025-2026',
      tuitionFee: 3500.00,
      transportFee: 500.00,
      examFee: 300.00,
      libraryFee: 200.00,
      sportsFee: 350.00,
      otherCharges: 150.00,
      paymentDeadline: DateTime(2026, 3, 31),
      description: 'Term 2 fees for academic year 2025-2026',
    );
  }

  /// Get available payment methods (dummy data)
  static List<PaymentMethod> getPaymentMethods() {
    return [
      PaymentMethod(
        id: 'PM001',
        name: 'Online Banking',
        description: 'Direct bank transfer via online banking',
        isEnabled: true,
        iconName: 'account_balance',
        transactionFee: 0.0,
      ),
      PaymentMethod(
        id: 'PM002',
        name: 'Card Payment',
        description: 'Pay using credit or debit card',
        isEnabled: true,
        iconName: 'credit_card',
        transactionFee: 2.5,
      ),
      PaymentMethod(
        id: 'PM003',
        name: 'Mobile Money',
        description: 'Pay using mobile money services',
        isEnabled: false,
        iconName: 'phone_android',
        transactionFee: 1.0,
      ),
    ];
  }

  /// Get pending/overdue payment records
  static List<PaymentRecord> getPendingPayments() {
    return getAllPaymentRecords()
        .where((record) => record.status == PaymentStatus.pending)
        .toList();
  }

  /// Get overdue payments (pending past deadline)
  static List<PaymentRecord> getOverduePayments(DateTime deadline) {
    return getAllPaymentRecords()
        .where((record) => record.isOverdue(deadline))
        .toList();
  }

  /// Update payment status (simulated - returns updated record)
  static PaymentRecord updatePaymentStatus(
    PaymentRecord record,
    PaymentStatus newStatus,
  ) {
    // In a real app, this would call an API
    return record.copyWith(status: newStatus);
  }

  /// Send payment reminder (simulated)
  static Future<bool> sendPaymentReminder(PaymentRecord record) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would send email/SMS
    return true;
  }

  /// Update fee structure (simulated)
  static Future<FeeStructure> updateFeeStructure(FeeStructure feeStructure) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, this would call an API
    return feeStructure;
  }

  /// Toggle payment method (simulated)
  static PaymentMethod togglePaymentMethod(PaymentMethod method) {
    // In a real app, this would call an API
    return method.copyWith(isEnabled: !method.isEnabled);
  }
}

