/// Model class representing the fee structure for the school
/// Contains tuition fees, other charges, and payment deadlines
class FeeStructure {
  final String id;
  final String academicYear;
  final double tuitionFee;
  final double transportFee;
  final double examFee;
  final double libraryFee;
  final double sportsFee;
  final double otherCharges;
  final DateTime paymentDeadline;
  final String? description;

  FeeStructure({
    required this.id,
    required this.academicYear,
    required this.tuitionFee,
    this.transportFee = 0.0,
    this.examFee = 0.0,
    this.libraryFee = 0.0,
    this.sportsFee = 0.0,
    this.otherCharges = 0.0,
    required this.paymentDeadline,
    this.description,
  });

  /// Calculate total fees
  double get totalFees {
    return tuitionFee +
        transportFee +
        examFee +
        libraryFee +
        sportsFee +
        otherCharges;
  }

  /// Get breakdown of all fees
  Map<String, double> get feeBreakdown {
    return {
      'Tuition Fee': tuitionFee,
      'Transport Fee': transportFee,
      'Exam Fee': examFee,
      'Library Fee': libraryFee,
      'Sports Fee': sportsFee,
      'Other Charges': otherCharges,
    };
  }

  /// Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'academicYear': academicYear,
      'tuitionFee': tuitionFee,
      'transportFee': transportFee,
      'examFee': examFee,
      'libraryFee': libraryFee,
      'sportsFee': sportsFee,
      'otherCharges': otherCharges,
      'paymentDeadline': paymentDeadline.toIso8601String(),
      'description': description,
    };
  }

  /// Create from JSON
  factory FeeStructure.fromJson(Map<String, dynamic> json) {
    return FeeStructure(
      id: json['id'] as String,
      academicYear: json['academicYear'] as String,
      tuitionFee: (json['tuitionFee'] as num).toDouble(),
      transportFee: (json['transportFee'] as num?)?.toDouble() ?? 0.0,
      examFee: (json['examFee'] as num?)?.toDouble() ?? 0.0,
      libraryFee: (json['libraryFee'] as num?)?.toDouble() ?? 0.0,
      sportsFee: (json['sportsFee'] as num?)?.toDouble() ?? 0.0,
      otherCharges: (json['otherCharges'] as num?)?.toDouble() ?? 0.0,
      paymentDeadline: DateTime.parse(json['paymentDeadline'] as String),
      description: json['description'] as String?,
    );
  }

  /// Create a copy with updated fields
  FeeStructure copyWith({
    String? id,
    String? academicYear,
    double? tuitionFee,
    double? transportFee,
    double? examFee,
    double? libraryFee,
    double? sportsFee,
    double? otherCharges,
    DateTime? paymentDeadline,
    String? description,
  }) {
    return FeeStructure(
      id: id ?? this.id,
      academicYear: academicYear ?? this.academicYear,
      tuitionFee: tuitionFee ?? this.tuitionFee,
      transportFee: transportFee ?? this.transportFee,
      examFee: examFee ?? this.examFee,
      libraryFee: libraryFee ?? this.libraryFee,
      sportsFee: sportsFee ?? this.sportsFee,
      otherCharges: otherCharges ?? this.otherCharges,
      paymentDeadline: paymentDeadline ?? this.paymentDeadline,
      description: description ?? this.description,
    );
  }

  /// Check if payment deadline has passed
  bool get isDeadlinePassed {
    return DateTime.now().isAfter(paymentDeadline);
  }

  /// Get days remaining until deadline
  int get daysUntilDeadline {
    return paymentDeadline.difference(DateTime.now()).inDays;
  }
}

