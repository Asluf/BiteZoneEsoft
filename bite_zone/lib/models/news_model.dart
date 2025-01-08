class NewsArticle {
  final Source source;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String? content;

  NewsArticle({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      source: Source.fromJson(json['source']),
      title: json['title'],
      description: json['description'] ?? '',
      url: json['url'],
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'sourceId': source.id,
      'sourceName': source.name,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  static NewsArticle fromMap(Map<String, dynamic> map) {
    return NewsArticle(
      source: Source(id: map['sourceId'], name: map['sourceName']),
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }
}

class Source {
  final String id;
  final String name;
  Source({
    required this.id,
    required this.name,
  });
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'],
    );
  }
}
