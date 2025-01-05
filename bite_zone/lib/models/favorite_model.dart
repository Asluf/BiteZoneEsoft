import 'place_model.dart';
import 'user_model.dart';

class Favorite {
  final String? id;
  final Place place;
  final User user;

  Favorite({
    this.id,
    required this.place,
    required this.user,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['_id'],
      place: Place.fromJson(json['place']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'place': place.toMap(),
      'user': user.toMap(),
    };
  }

  static Favorite fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['_id'],
      place: Place.fromMap(map['place']),
      user: User.fromMap(map['user']),
    );
  }
}