import 'dart:convert';
import 'dart:io';
import 'package:bite_zone/models/place_model.dart';
import 'package:bite_zone/models/review_model.dart';
import 'package:bite_zone/services/hive_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:bite_zone/services/bite_zone_db_service.dart';
import 'package:bite_zone/models/user_model.dart';

class UserService {
  final String baseUrl = 'https://bitezone.onrender.com/api/auth/user';
  HiveService hiveService = HiveService();

  Future<bool> isConnectedToInternet() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      // Check actual internet access
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> getProfile() async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('$baseUrl/get-user-profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData['success'] == true && responseData['data'] != null) {
        final updatedUser = User.fromJson(responseData['data']);

        final updatedUserMap = updatedUser.toMap();
        updatedUserMap['token'] = user['token'];

        await BiteZoneDBService.instance.updateUser(updatedUserMap);
      } else {
        throw Exception('User data not found in response');
      }
    } else {
      throw Exception('Failed to get profile');
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updatedUser) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.put(
      Uri.parse('$baseUrl/update-user-profile'),
      headers: headers,
      body: jsonEncode(updatedUser),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] != true) {
        throw Exception('Failed to update profile: ${responseData['error']}');
      }
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<List<Place>> getAllPlaces({String? search, String? city}) async {
    try {
      if (await isConnectedToInternet()) {
        await fetchAndCacheAllPlaces(search: search, city: city);
      }
      return await hiveService.getPlaces();
    } catch (error) {
      return await hiveService.getPlaces();
    }
  }

  Future<void> fetchAndCacheAllPlaces({String? search, String? city}) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri =
        Uri.parse('$baseUrl/get-all-places').replace(queryParameters: {
      if (search != null) 'search': search,
      if (city != null) 'city': city,
    });

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final List<dynamic> placesJson = responseData['data'];
        final places = placesJson.map((data) => Place.fromJson(data)).toList();
        // store in hive box
        await hiveService.savePlaces(places);
        // return places;
      } else {
        throw Exception('Failed to fetch places: ${responseData['error']}');
      }
    } else {
      throw Exception('Failed to fetch places');
    }
  }

  Future<List<Place>> getTrendingPlaces() async {
    try {
      if (await isConnectedToInternet()) {
        await fetchAndCacheTrendingPlaces();
      }
      return await hiveService.getTrendingPlaces();
    } catch (error) {
      return await hiveService.getTrendingPlaces();
    }
  }

  Future<void> fetchAndCacheTrendingPlaces() async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$baseUrl/get-trending-places');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final List<dynamic> placesJson = responseData['data'];
        final places = placesJson.map((data) => Place.fromJson(data)).toList();
        // store in hive box
        await hiveService.saveTrendingPlaces(places);
      } else {
        throw Exception(
            'Failed to fetch trending places: ${responseData['error']}');
      }
    } else {
      throw Exception('Failed to fetch trending places');
    }
  }

  Future<List<Place>> getAllFavoritePlaces() async {
    try {
      if (await isConnectedToInternet()) {
        await fetchAndCacheFavoritePlaces();
      }
      return await hiveService.getFavoritePlaces();
    } catch (error) {
      return await hiveService.getFavoritePlaces();
    }
  }

  Future<void> fetchAndCacheFavoritePlaces() async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$baseUrl/get-all-favorite-places');

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['success'] == true) {
        final List<dynamic> placesJson = responseData['data'];
        final places = placesJson.map((data) => Place.fromJson(data)).toList();
        // store in hive box
        await hiveService.saveFavoritePlaces(places);
      } else {
        throw Exception(
            'Failed to fetch favorite places: ${responseData['error']}');
      }
    } else {
      throw Exception('Failed to fetch favorite places');
    }
  }

  Future<void> addFavorite(String placeId) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('$baseUrl/add-favorite'),
      headers: headers,
      body: jsonEncode({'placeId': placeId}),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception('Failed to add favorite: ${responseData['error']}');
    }
  }

  Future<bool> isFavorite(String placeId) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$baseUrl/is-favorite').replace(queryParameters: {
      'placeId': placeId,
    });

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['data'] as bool;
    } else {
      throw Exception('Failed to check favorite status');
    }
  }

  Future<void> addReview(String placeId, double rating, String message) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('$baseUrl/add-review'),
      headers: headers,
      body: jsonEncode({
        'placeId': placeId,
        'rating': rating,
        'message': message,
      }),
    );

    if (response.statusCode != 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception('Failed to add review: ${responseData['error']}');
    }
  }

  Future<List<Review>> getReviews(String placeId) async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user == null || user['token'] == null) {
      throw Exception('No token found');
    }

    final String token = user['token'];

    final Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final Uri uri = Uri.parse('$baseUrl/get-reviews').replace(queryParameters: {
      'placeId': placeId,
    });

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body)['data'];
      return responseData.map((data) => Review.fromJson(data)).toList();
    } else {
      throw Exception('Failed to fetch reviews');
    }
  }
}
