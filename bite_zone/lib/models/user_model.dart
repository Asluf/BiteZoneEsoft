class User {
  final String id;
  final String name;
  final String role;
  final String email;
  final String? token;
  final int? age;
  final String? city;
  final String? address;
  final String? mobile;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.token,
    this.age,
    this.city,
    this.address,
    this.mobile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      role: json['role'],
      email: json['email'],
      token: json['token'],
      age: json['age'],
      city: json['city'],
      address: json['address'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'role': role,
      'email': email,
      'token': token,
      'age': age,
      'city': city,
      'address': address,
      'mobile': mobile,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      name: map['name'],
      role: map['role'],
      email: map['email'],
      token: map['token'],
      age: map['age'],
      city: map['city'],
      address: map['address'],
      mobile: map['mobile'],
    );
  }
}