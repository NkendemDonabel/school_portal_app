import 'package:flutter/material.dart';
import '../../models/fee_structure.dart';

/// Widget to display and edit the fee structure
/// Shows breakdown of all fees and allows editing
class FeeStructureCard extends StatelessWidget {
  final FeeStructure feeStructure;
  final VoidCallback onEdit;

  const FeeStructureCard({
    super.key,
    required this.feeStructure,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and edit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Fee Structure',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                  tooltip: 'Edit Fee Structure',
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Academic year
            Text(
              'Academic Year: ${feeStructure.academicYear}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const Divider(height: 24),
            // Fee breakdown
            _buildFeeRow('Tuition Fee', feeStructure.tuitionFee),
            _buildFeeRow('Transport Fee', feeStructure.transportFee),
            _buildFeeRow('Exam Fee', feeStructure.examFee),
            _buildFeeRow('Library Fee', feeStructure.libraryFee),
            _buildFeeRow('Sports Fee', feeStructure.sportsFee),
            _buildFeeRow('Other Charges', feeStructure.otherCharges),
            const Divider(height: 24),
            // Total fee
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Fees',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${feeStructure.totalFees.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Payment deadline
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: feeStructure.isDeadlinePassed
                    ? Colors.red.shade50
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: feeStructure.isDeadlinePassed
                      ? Colors.red.shade200
                      : Colors.blue.shade200,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event,
                    color: feeStructure.isDeadlinePassed
                        ? Colors.red.shade700
                        : Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Deadline',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatDate(feeStructure.paymentDeadline),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: feeStructure.isDeadlinePassed
                                ? Colors.red.shade700
                                : Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!feeStructure.isDeadlinePassed)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${feeStructure.daysUntilDeadline} days left',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Description if available
            if (feeStructure.description != null) ...[
              const SizedBox(height: 12),
              Text(
                feeStructure.description!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build a single fee row
  Widget _buildFeeRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  /// Format date to readable string
  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

