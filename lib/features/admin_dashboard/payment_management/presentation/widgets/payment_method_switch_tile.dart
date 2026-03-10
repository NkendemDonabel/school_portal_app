import 'package:flutter/material.dart';
import '../../models/payment_method.dart';

/// Widget to display and toggle payment method settings
/// Shows each payment method with a switch to enable/disable
class PaymentMethodSwitchTile extends StatelessWidget {
  final PaymentMethod paymentMethod;
  final ValueChanged<bool> onToggle;

  const PaymentMethodSwitchTile({
    super.key,
    required this.paymentMethod,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SwitchListTile(
        value: paymentMethod.isEnabled,
        onChanged: onToggle,
        title: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paymentMethod.isEnabled
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconData(paymentMethod.iconName),
                color: paymentMethod.isEnabled
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Name
            Expanded(
              child: Text(
                paymentMethod.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: paymentMethod.isEnabled
                      ? Colors.black87
                      : Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 52, top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                paymentMethod.description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              if (paymentMethod.transactionFee != null &&
                  paymentMethod.transactionFee! > 0) ...[
                const SizedBox(height: 4),
                Text(
                  paymentMethod.transactionFeeDisplay,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
        activeThumbColor: Theme.of(context).primaryColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  /// Get IconData from string name
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'phone_android':
        return Icons.phone_android;
      default:
        return Icons.payment;
    }
  }
}


