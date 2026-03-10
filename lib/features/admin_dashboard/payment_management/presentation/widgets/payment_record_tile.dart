import 'package:flutter/material.dart';
import '../../models/payment_record.dart';

/// Widget to display a single payment record as a list tile
/// Includes student name, amount, date, status, and actions
class PaymentRecordTile extends StatelessWidget {
  final PaymentRecord record;
  final Function(PaymentStatus) onStatusChanged;
  final VoidCallback onSendReminder;

  const PaymentRecordTile({
    super.key,
    required this.record,
    required this.onStatusChanged,
    required this.onSendReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student name and status row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Student name
                Expanded(
                  child: Text(
                    record.studentName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Status chip
                _buildStatusChip(record.status),
              ],
            ),
            const SizedBox(height: 8),
            // Amount and date row
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 18,
                  color: Colors.green.shade700,
                ),
                const SizedBox(width: 6),
                Text(
                  '\$${record.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  _formatDate(record.paymentDate),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            // Transaction ID if available
            if (record.transactionId != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'TXN: ${record.transactionId}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            // Action buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<PaymentStatus>(
                      value: record.status,
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, size: 20),
                      items: PaymentStatus.values.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Row(
                            children: [
                              Icon(
                                _getStatusIcon(status),
                                size: 16,
                                color: Color(status.colorValue),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                status.displayName,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          onStatusChanged(newStatus);
                        }
                      },
                    ),
                  ),
                ),
                // Send reminder button (only for pending payments)
                if (record.status == PaymentStatus.pending) ...[
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: onSendReminder,
                    icon: const Icon(Icons.notifications, size: 16),
                    label: const Text('Remind'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build status chip with color
  Widget _buildStatusChip(PaymentStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Color(status.colorValue).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(status.colorValue).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getStatusIcon(status),
            size: 14,
            color: Color(status.colorValue),
          ),
          const SizedBox(width: 4),
          Text(
            status.displayName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(status.colorValue),
            ),
          ),
        ],
      ),
    );
  }

  /// Get icon for payment status
  IconData _getStatusIcon(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.paid:
        return Icons.check_circle;
      case PaymentStatus.pending:
        return Icons.pending;
      case PaymentStatus.failed:
        return Icons.cancel;
    }
  }

  /// Format date to readable string
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

