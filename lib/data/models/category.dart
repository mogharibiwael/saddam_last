class Category {
  final int id;
  final int type;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
  });

  // Convert a Category object into a Map object for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'description': description,
    };
  }

  // Extract a Category object from a Map object
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      type: map['type'],
      name: map['name'],
      description: map['description'],
    );
  }
}
