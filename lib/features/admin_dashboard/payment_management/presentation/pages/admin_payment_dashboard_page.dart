import 'package:flutter/material.dart';
import '../../models/payment_record.dart';
import '../../models/fee_structure.dart';
import '../../models/payment_method.dart';
import '../../services/payment_service.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_record_tile.dart';
import '../widgets/fee_structure_card.dart';
import '../widgets/payment_method_switch_tile.dart';

/// Main Admin Payment Dashboard Page
/// Displays payment reports, fee structure, and payment methods configuration
class AdminPaymentDashboardPage extends StatefulWidget {
  const AdminPaymentDashboardPage({super.key});

  @override
  State<AdminPaymentDashboardPage> createState() => _AdminPaymentDashboardPageState();
}

class _AdminPaymentDashboardPageState extends State<AdminPaymentDashboardPage> {
  // State variables
  late List<PaymentRecord> _paymentRecords;
  late FeeStructure _feeStructure;
  late List<PaymentMethod> _paymentMethods;
  late Map<String, double> _paymentSummary;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// Load all data from service
  void _loadData() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _paymentRecords = PaymentService.getAllPaymentRecords();
        _feeStructure = PaymentService.getFeeStructure();
        _paymentMethods = PaymentService.getPaymentMethods();
        _paymentSummary = PaymentService.getPaymentSummary();
        _isLoading = false;
      });
    });
  }

  /// Handle payment status change
  void _handleStatusChange(PaymentRecord record, PaymentStatus newStatus) {
    setState(() {
      final index = _paymentRecords.indexWhere((r) => r.id == record.id);
      if (index != -1) {
        _paymentRecords[index] = PaymentService.updatePaymentStatus(record, newStatus);
        _paymentSummary = PaymentService.getPaymentSummary();
      }
    });

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment status updated to ${newStatus.displayName}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Handle send reminder action
  void _handleSendReminder(PaymentRecord record) async {
    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            SizedBox(width: 12),
            Text('Sending reminder...'),
          ],
        ),
        duration: Duration(seconds: 2),
      ),
    );

    // Simulate sending reminder
    final success = await PaymentService.sendPaymentReminder(record);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reminder sent to ${record.studentName}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Handle edit fee structure
  void _handleEditFeeStructure() {
    showDialog(
      context: context,
      builder: (context) => _buildEditFeeDialog(),
    );
  }

  /// Handle toggle payment method
  void _handleTogglePaymentMethod(PaymentMethod method, bool isEnabled) {
    setState(() {
      final index = _paymentMethods.indexWhere((m) => m.id == method.id);
      if (index != -1) {
        _paymentMethods[index] = PaymentService.togglePaymentMethod(method);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${method.name} ${isEnabled ? 'enabled' : 'disabled'}',
        ),
        backgroundColor: isEnabled ? Colors.green : Colors.orange,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Payment Summary Cards
                  _buildSectionHeader('Payment Reports'),
                  _buildPaymentSummary(),
                  const SizedBox(height: 16),

                  // Section 2: Fee Structure
                  _buildSectionHeader('Fee Structure'),
                  FeeStructureCard(
                    feeStructure: _feeStructure,
                    onEdit: _handleEditFeeStructure,
                  ),
                  const SizedBox(height: 16),

                  // Section 3: Payment History
                  _buildSectionHeader('Payment History'),
                  _buildPaymentHistory(),
                  const SizedBox(height: 16),

                  // Section 4: Payment Methods Configuration
                  _buildSectionHeader('Payment Methods'),
                  _buildPaymentMethods(),
                  const SizedBox(height: 80), // Extra space for FAB
                ],
              ),
            ),
      // Floating Action Button for quick actions
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showQuickActions,
        icon: const Icon(Icons.add),
        label: const Text('Quick Actions'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  /// Build payment summary section
  Widget _buildPaymentSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.6, // Increased from 1.5 to make cards shorter
        mainAxisSpacing: 4, // Reduced from 6
        crossAxisSpacing: 4, // Reduced from 6
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2), // Reduced padding
        children: [
          PaymentSummaryCard(
            title: 'Total Payments',
            amount: '\$${_paymentSummary['totalPayments']!.toStringAsFixed(0)}',
            icon: Icons.payments,
            color: Colors.blue.shade700,
          ),
          PaymentSummaryCard(
            title: 'Paid Fees',
            amount: '\$${_paymentSummary['paidFees']!.toStringAsFixed(0)}',
            icon: Icons.check_circle,
            color: Colors.green.shade700,
          ),
          PaymentSummaryCard(
            title: 'Pending Fees',
            amount: '\$${_paymentSummary['pendingFees']!.toStringAsFixed(0)}',
            icon: Icons.pending,
            color: Colors.orange.shade700,
          ),
          PaymentSummaryCard(
            title: 'Failed Payments',
            amount: '\$${_paymentSummary['failedPayments']!.toStringAsFixed(0)}',
            icon: Icons.error,
            color: Colors.red.shade700,
          ),
        ],
      ),
    );
  }

  /// Build payment history section
  Widget _buildPaymentHistory() {
    if (_paymentRecords.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No payment records found'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _paymentRecords.length,
      itemBuilder: (context, index) {
        final record = _paymentRecords[index];
        return PaymentRecordTile(
          record: record,
          onStatusChanged: (newStatus) => _handleStatusChange(record, newStatus),
          onSendReminder: () => _handleSendReminder(record),
        );
      },
    );
  }

  /// Build payment methods section
  Widget _buildPaymentMethods() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final method = _paymentMethods[index];
        return PaymentMethodSwitchTile(
          paymentMethod: method,
          onToggle: (isEnabled) => _handleTogglePaymentMethod(method, isEnabled),
        );
      },
    );
  }

  /// Build edit fee structure dialog
  Widget _buildEditFeeDialog() {
    final tuitionController = TextEditingController(
      text: _feeStructure.tuitionFee.toString(),
    );
    final transportController = TextEditingController(
      text: _feeStructure.transportFee.toString(),
    );
    final examController = TextEditingController(
      text: _feeStructure.examFee.toString(),
    );

    return AlertDialog(
      title: const Text('Edit Fee Structure'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tuitionController,
              decoration: const InputDecoration(
                labelText: 'Tuition Fee',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: transportController,
              decoration: const InputDecoration(
                labelText: 'Transport Fee',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: examController,
              decoration: const InputDecoration(
                labelText: 'Exam Fee',
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _feeStructure = _feeStructure.copyWith(
                tuitionFee: double.tryParse(tuitionController.text) ?? _feeStructure.tuitionFee,
                transportFee: double.tryParse(transportController.text) ?? _feeStructure.transportFee,
                examFee: double.tryParse(examController.text) ?? _feeStructure.examFee,
              );
            });
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fee structure updated'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  /// Show quick actions bottom sheet
  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.file_download, color: Colors.blue),
              title: const Text('Export Payment Report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export feature coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active, color: Colors.orange),
              title: const Text('Send Bulk Reminders'),
              onTap: () {
                Navigator.pop(context);
                _sendBulkReminders();
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics, color: Colors.green),
              title: const Text('View Analytics'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Analytics feature coming soon')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Send bulk reminders to all pending payments
  void _sendBulkReminders() {
    final pendingPayments = PaymentService.getPendingPayments();

    if (pendingPayments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No pending payments to remind'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sending reminders to ${pendingPayments.length} students...'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate sending bulk reminders
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reminders sent to ${pendingPayments.length} students'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }
}

