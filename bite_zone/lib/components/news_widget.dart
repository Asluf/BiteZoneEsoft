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

  @override
  void initState() {
    super.initState();
    _environmentNews = NewsService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsArticle>>(
      future: _environmentNews,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: No Offline Access'));
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
