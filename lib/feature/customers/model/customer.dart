class Customer {
  final int id;
  final int userType;
  final String name;
  final String phone;
  final String phone2;
  final String address;
  final String createAt;
  final String updateAt;

  Customer({
    required this.id,
    required this.userType,
    required this.name,
    required this.phone,
    required this.phone2,
    required this.address,
    required this.createAt,
    required this.updateAt,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      userType: map['userType'],
      name: map['name'],
      phone: map['phone'],
      phone2: map['phone2'],
      address: map['address'],
      createAt: map['create_at'],
      updateAt: map['update_at'],
    );
  }
}