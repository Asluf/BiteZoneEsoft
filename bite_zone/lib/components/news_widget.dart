import 'package:bite_zone/services/user_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:bite_zone/components/news_card.dart';
import 'package:bite_zone/models/news_model.dart';
import 'package:bite_zone/services/news_service.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  Future<List<NewsArticle>>? _environmentNews;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _environmentNews = NewsService().fetchNews();
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await UserService().isConnectedToInternet();
    setState(() {
      _isConnected = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsArticle>>(
      future: _environmentNews,
      builder: (context, snapshot) {
        if (!_isConnected) {
          return const Center(child: Text('No Internet Connection'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSecondary));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No results found'));
        } else {
          return Column(
            children: snapshot.data!
                .map((article) => NewsCard(article: article))
                .toList(),
          );
        }
      },
    );
  }
}
