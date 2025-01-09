import 'package:bite_zone/components/place_card.dart';
import 'package:bite_zone/components/place_detail.dart';
import 'package:bite_zone/models/place_model.dart';
import 'package:bite_zone/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class UserTrendingScreen extends StatefulWidget {
  const UserTrendingScreen({super.key});

  @override
  State<UserTrendingScreen> createState() => _UserTrendingScreenState();
}

class _UserTrendingScreenState extends State<UserTrendingScreen> {
  late Future<List<Place>> _placesFuture;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _placesFuture = _fetchTrendingPlaces();
  }

  Future<List<Place>> _fetchTrendingPlaces() async {
    return await UserService().getTrendingPlaces();
  }

  void _onPlaceSelected(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetail(place: place),
      ),
    );
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await UserService().isConnectedToInternet();
    setState(() {
      _isConnected = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<Place>>(
                future: _placesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No places found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final place = snapshot.data![index];
                        return PlaceCard(
                          place: place,
                          onTap: () {
                            _onPlaceSelected(place);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
