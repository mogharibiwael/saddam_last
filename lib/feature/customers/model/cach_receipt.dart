class CatchReceipt {
  int? id;
  String? name;
  int? customerId;
  int? price;
  int? total;
  int? forHim;
  String? customerName;
  String? createdAt;
  String? updatedAt;

  CatchReceipt({
    this.id,
    this.name,
    this.customerId,
    this.price,
    this.total,
    this.forHim,
    this.customerName,
    this.createdAt,
    this.updatedAt,
  });

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
}