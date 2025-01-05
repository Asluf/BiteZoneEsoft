import 'package:bite_zone/models/place_model.dart';
import 'package:hive/hive.dart';

class HiveService {
  Future<void> savePlaces(List<Place> places) async {
    final box = Hive.box('placesBox');
    await box.put('places', places.map((place) => place.toMap()).toList());
  }

  Future<List<Place>> getPlaces() async {
    final box = Hive.box('placesBox');
    final placesList = box.get('places', defaultValue: []) as List<dynamic>;
    return placesList.map((placeMap) => Place.fromMap(placeMap)).toList();
  }
}
