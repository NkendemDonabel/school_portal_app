/// Model class representing a payment method configuration
/// Allows enabling/disabling different payment methods
class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final bool isEnabled;
  final String iconName;
  final double? transactionFee;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.isEnabled,
    required this.iconName,
    this.transactionFee,
  });

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'isEnabled': isEnabled,
      'iconName': iconName,
      'transactionFee': transactionFee,
    };
  }

  /// Create from JSON
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isEnabled: json['isEnabled'] as bool,
      iconName: json['iconName'] as String,
      transactionFee: (json['transactionFee'] as num?)?.toDouble(),
    );
  }

  /// Create a copy with updated fields
  PaymentMethod copyWith({
    String? id,
    String? name,
    String? description,
    bool? isEnabled,
    String? iconName,
    double? transactionFee,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      iconName: iconName ?? this.iconName,
      transactionFee: transactionFee ?? this.transactionFee,
    );
  }

  /// Get display text for transaction fee
  String get transactionFeeDisplay {
    if (transactionFee == null || transactionFee == 0) {
      return 'No transaction fee';
    }
    return 'Transaction fee: \$${transactionFee!.toStringAsFixed(2)}';
  }
}

