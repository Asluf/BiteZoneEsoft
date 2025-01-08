class Review {
  final String id;
  final String placeId;
  final String userId;
  final String userName;
  final double rating;
  final String message;

  Review({
    required this.id,
    required this.placeId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.message,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'],
      placeId: json['place'],
      userId: json['user']['_id'],
      userName: json['user']['name'],
      rating: (json['rating'] as num).toDouble(),
      message: json['message'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'place': placeId,
      'user': userId,
      'userName': userName,
      'rating': rating,
      'message': message,
    };
  }
}