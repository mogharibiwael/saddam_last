class CatchReceipt {
  final int id;  // ID will be auto-incremented
  final String name;
  final int customerId;
  final int price;
  final int total;
  final int forHim;
  final String customerName;
  final String createdAt;  // Storing date/time as String
  final String updatedAt;  // Storing date/time as String

  CatchReceipt({
    required this.id,
    required this.name,
    required this.customerId,
    required this.price,
    required this.total,
    required this.forHim,
    required this.customerName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a CatchReceipt object into a Map object for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'customer_id': customerId,
      'price': price,
      'total': total,
      'for_him': forHim,
      'customer_name': customerName,
      'create_at': createdAt,
      'update_at': updatedAt,
    };
  }

  // Extract a CatchReceipt object from a Map object
  factory CatchReceipt.fromMap(Map<String, dynamic> map) {
    return CatchReceipt(
      id: map['id'],
      name: map['name'],
      customerId: map['customer_id'],
      price: map['price'],
      total: map['total'],
      forHim: map['for_him'],
      customerName: map['customer_name'],
      createdAt: map['create_at'],
      updatedAt: map['update_at'],
    );
  }
}