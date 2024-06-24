class SourceNewsModel {
  late String status;
  late int totalResults;
  late List<Article> articles;

  SourceNewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory SourceNewsModel.fromJson(Map<String, dynamic> json) {
    return SourceNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'] != null
          ? List<Article>.from(json['articles'].map((x) => Article.fromJson(x)))
          : [], // Handle case where articles might be null or empty
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((article) => article.toJson()).toList(),
    };
    return data;
  }

  @override
  String toString() {
    return 'SourceNewsModel{status: $status, totalResults: $totalResults, articles: $articles}';
  }
}

class Article {
  late Source source;
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String? content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
    return data;
  }

  @override
  String toString() {
    return 'Article{source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}

class Source {
  late String id;
  late String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
    };
    return data;
  }

  @override
  String toString() {
    return 'Source{id: $id, name: $name}';
  }
}
