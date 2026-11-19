class Purchasing {
  final int id; // ID will be auto-incremented
  final String name;
  final int price;
  final int total;
  final int type;
  final int categoryId;
  final String categoryName;
  final String? note; // Note can be null
  final String createdAt; // Storing date/time as String
  final String updatedAt; // Storing date/time as String

  Purchasing({
    required this.id,
    required this.name,
    required this.price,
    required this.total,
    required this.type,
    required this.categoryId,
    required this.categoryName,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Purchasing object into a Map object for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'total': total,
      'type': type,
      'category_id': categoryId,
      'category_name': categoryName,
      'note': note,
      'create_at': createdAt,
      'update_at': updatedAt,
    };
  }

  // Extract a Purchasing object from a Map object
  factory Purchasing.fromMap(Map<String, dynamic> map) {
    return Purchasing(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      total: map['total'],
      type: map['type'],
      categoryId: map['category_id'],
      categoryName: map['category_name'],
      note: map['note'],
      createdAt: map['create_at'],
      updatedAt: map['update_at'],
    );
  }
}
