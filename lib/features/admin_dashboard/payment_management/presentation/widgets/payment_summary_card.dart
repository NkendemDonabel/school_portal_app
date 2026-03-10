import 'package:flutter/material.dart';

/// Reusable widget to display payment summary cards
/// Shows key metrics like total payments, pending fees, etc.
class PaymentSummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;
  final Color? backgroundColor;

  const PaymentSummaryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor ?? color.withValues(alpha: 0.1),
              backgroundColor?.withValues(alpha: 0.05) ?? color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
