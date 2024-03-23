// ignore_for_file: public_member_api_docs, sort_constructors_first
class Customer {
  final int id;
  final int registerNumber;
  final String name;
  final String nic;
  final String mobile;
  final String address;

  Customer({
    required this.id,
    required this.registerNumber,
    required this.name,
    required this.nic,
    required this.mobile,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as int,
      registerNumber: json['registerNumber'] as int,
      name: json['name'] as String,
      nic: json['nic'] as String,
      mobile: json['mobile'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registerNumber': registerNumber,
      'name': name,
      'nic': nic,
      'mobile': mobile,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'Customer(id: $id, registerNumber: $registerNumber, name: $name, nic: $nic, mobile: $mobile, address: $address)';
  }
}
