import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bite_zone/models/place_model.dart';
import 'package:bite_zone/models/review_model.dart';
import 'package:bite_zone/services/user_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetail extends StatefulWidget {
  final Place place;

  const PlaceDetail({super.key, required this.place});

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  bool _isFavorite = false;
  late Future<List<Review>> _reviewsFuture;
  double _rating = 0;
  String _message = '';
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _checkFavoriteStatus();
    _reviewsFuture = _fetchReviews();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      final isFavorite = await UserService().isFavorite(widget.place.id!);
      setState(() {
        _isFavorite = isFavorite;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await UserService().isConnectedToInternet();
    setState(() {
      _isConnected = connectivityResult;
    });
  }

  Future<void> _toggleFavorite() async {
    try {
      await UserService().addFavorite(widget.place.id!);
      setState(() {
        _isFavorite = !_isFavorite;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> launchUrlExternal(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<List<Review>> _fetchReviews() async {
    return await UserService().getReviews(widget.place.id!);
  }

  Future<void> _addReview(double rating, String message) async {
    try {
      await UserService().addReview(widget.place.id!, rating, message);
      setState(() {
        _reviewsFuture = _fetchReviews();
      });
    } catch (e) {
      // Handle error
    }
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Review'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                const SizedBox(height: 17),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)),
                  onChanged: (value) {
                    setState(() {
                      _message = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary))),
            TextButton(
              onPressed: () {
                _addReview(_rating, _message);
                Navigator.of(context).pop();
              },
              child: Text('Submit',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place.name,
          style: const TextStyle(fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
              size: 30.0,
            ),
            onPressed: _toggleFavorite,
            iconSize: 30.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.place.images.isNotEmpty &&
                  widget.place.images[0].isNotEmpty)
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.place.images[0],
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                '${widget.place.name} - ${widget.place.city}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Description: ${widget.place.description}',
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Address: ${widget.place.address}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: widget.place.categories.map((category) {
                  return Chip(
                    label: Text(category.toString().split('.').last),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Text(
                'Updated by: ${widget.place.updatedBy.name}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final String googleMapsUrl =
                          "https://www.google.com/maps?q=${widget.place.latitude},${widget.place.longitude}";
                      final url = Uri.parse(googleMapsUrl);
                      await launchUrlExternal(url);
                    },
                    icon: const Icon(Icons.map, color: Colors.white),
                    label: const Text('Navigate'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final urlString = 'tel:${widget.place.phone}';
                      final url = Uri.parse(urlString);
                      await launchUrlExternal(url);
                    },
                    icon: const Icon(Icons.phone, color: Colors.white),
                    label: const Text('Call Now'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _showAddReviewDialog,
                    icon: const Icon(Icons.add),
                    label: Text(
                      'Add Review',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Review>>(
                future: _reviewsFuture,
                builder: (context, snapshot) {
                  if (!_isConnected) {
                    return const Center(child: Text('No Internet Connection'));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onSecondary));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No reviews found'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((review) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            // color: Theme.of(context).colorScheme.primary,
                            child: ListTile(
                              title: Text(review.userName),
                              subtitle: Text(review.message),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(review.rating.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
