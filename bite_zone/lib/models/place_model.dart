import 'package:hive/hive.dart';

enum AvailableStatus {
  PENDING,
  AVAILABLE,
  UNAVAILABLE,
}

enum FoodDrinkCategories {
  RESTAURANT,
  CAFE,
  STREET_FOOD,
  BAR,
  DESSERT,
  BAKERY,
  SEAFOOD,
  LOCAL_CUISINE,
  FAST_FOOD,
  HEALTHY_OPTION,
}

@HiveType(typeId: 0)
class Place {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String address;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final double latitude;
  @HiveField(6)
  final double longitude;
  @HiveField(7)
  final List<String> images;
  @HiveField(8)
  final AvailableStatus status;
  @HiveField(9)
  final List<FoodDrinkCategories> categories;
  @HiveField(10)
  final String city;
  @HiveField(11)
  final UpdatedBy updatedBy;

  Place({
    this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.status,
    required this.categories,
    required this.city,
    required this.updatedBy,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      images: List<String>.from(json['images']),
      status: AvailableStatus.values.firstWhere(
          (e) => e.toString() == 'AvailableStatus.${json['status']}'),
      categories: (json['categories'] as List)
          .map((e) => FoodDrinkCategories.values
              .firstWhere((cat) => cat.toString() == 'FoodDrinkCategories.$e'))
          .toList(),
      city: json['city'],
      updatedBy: UpdatedBy.fromJson(json['updatedBy']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'status': status.toString().split('.').last,
      'categories':
          categories.map((e) => e.toString().split('.').last).toList(),
      'city': city,
      'updatedBy': updatedBy.toMap(),
    };
  }

  static Place fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      address: map['address'],
      phone: map['phone'],
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      images: List<String>.from(map['images']),
      status: AvailableStatus.values.firstWhere(
          (e) => e.toString() == 'AvailableStatus.${map['status']}'),
      categories: (map['categories'] as List)
          .map((e) => FoodDrinkCategories.values
              .firstWhere((cat) => cat.toString() == 'FoodDrinkCategories.$e'))
          .toList(),
      city: map['city'],
      updatedBy: UpdatedBy.fromJson(map['updatedBy']),
    );
  }
}

class UpdatedBy {
  final String id;
  final String name;

  UpdatedBy({
    required this.id,
    required this.name,
  });

  factory UpdatedBy.fromJson(Map<String, dynamic> json) {
    return UpdatedBy(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
