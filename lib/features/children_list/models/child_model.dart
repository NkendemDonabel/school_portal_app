class Child {
  final String id;
  final String name;
  final String grade;
  final String? photoUrl;

  Child({
    required this.id,
    required this.name,
    required this.grade,
    this.photoUrl,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'grade': grade,
      'photoUrl': photoUrl,
    };
  }

  // Create from JSON
  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'] as String,
      name: json['name'] as String,
      grade: json['grade'] as String,
      photoUrl: json['photoUrl'] as String?,
    );
  }

  // Copy with method for immutability
  Child copyWith({
    String? id,
    String? name,
    String? grade,
    String? photoUrl,
  }) {
    return Child(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: grade ?? this.grade,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

