import 'package:bite_zone/components/place_card.dart';
import 'package:bite_zone/components/place_detail.dart';
import 'package:bite_zone/components/place_grid_card.dart';
import 'package:bite_zone/models/place_model.dart';
import 'package:bite_zone/services/cities.dart';
import 'package:bite_zone/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  late Future<List<Place>> _placesFuture;
  String _searchQuery = '';
  String? _selectedCity;
  bool _isConnected = true;
  bool _isGridView = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _placesFuture = _fetchAllPlaces();
  }

  Future<List<Place>> _fetchAllPlaces() async {
    return await UserService()
        .getAllPlaces(search: _searchQuery, city: _selectedCity);
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _placesFuture = _fetchAllPlaces();
    });
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await UserService().isConnectedToInternet();
    setState(() {
      _isConnected = connectivityResult;
    });
  }

  void _onCitySelected(String? city) {
    setState(() {
      _selectedCity = city == 'All Cities' ? null : city;
      _placesFuture = _fetchAllPlaces();
    });
  }

  void _onPlaceSelected(Place place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetail(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSecondary,
                              width: 2.0),
                        ),
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      onChanged: _onSearchChanged,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () async {
                      final selectedCity = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return CityFilterDialog(
                            selectedCity: _selectedCity,
                            onCitySelected: _onCitySelected,
                          );
                        },
                      );
                      if (selectedCity != null) {
                        _onCitySelected(selectedCity);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter - ${_selectedCity ?? 'All Cities'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isGridView = !_isGridView;
                        });
                      },
                      icon: Icon(
                        _isGridView ? Icons.list : Icons.grid_on,
                        color: Colors.white,
                      ),
                      label: Text('View'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSecondary,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Place>>(
                future: _placesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onSecondary));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No places found'));
                  } else {
                    // Use either GridView or ListView based on _isGridView
                    if (_isGridView) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final place = snapshot.data![index];
                          return PlaceGridCard(
                            place: place,
                            onTap: () {
                              _onPlaceSelected(place);
                            },
                          );
                        },
                      );
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

class CityFilterDialog extends StatefulWidget {
  final String? selectedCity;
  final Function(String?) onCitySelected;

  const CityFilterDialog({
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  _CityFilterDialogState createState() => _CityFilterDialogState();
}

class _CityFilterDialogState extends State<CityFilterDialog> {
  String _searchQuery = '';
  List<String> _filteredCities = cities.toList()
    ..sort((a, b) => a.compareTo(b));

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredCities = cities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select City'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                filled: false,
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 2.0),
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _filteredCities.map((city) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(city),
                          onTap: () {
                            widget.onCitySelected(city);
                            Navigator.of(context).pop(city);
                          },
                          selected: city == widget.selectedCity,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
