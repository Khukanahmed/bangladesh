import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Article {
  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      urlToImage: json['urlToImage'] as String?,
      publishedAt: json['publishedAt'] as String?,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

class Source {
  final String? id;
  final String name;

  Source({this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] as String?, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

// ==================== lib/models/news_category.dart ====================
enum NewsCategory { topHeadlines, apple, tesla, techCrunch, wsj }

extension NewsCategoryExtension on NewsCategory {
  String get displayName {
    switch (this) {
      case NewsCategory.topHeadlines:
        return 'Top Headlines';
      case NewsCategory.apple:
        return 'Apple News';
      case NewsCategory.tesla:
        return 'Tesla News';
      case NewsCategory.techCrunch:
        return 'TechCrunch';
      case NewsCategory.wsj:
        return 'Wall Street Journal';
    }
  }

  IconData get icon {
    switch (this) {
      case NewsCategory.topHeadlines:
        return Icons.newspaper;
      case NewsCategory.apple:
        return Icons.apple;
      case NewsCategory.tesla:
        return Icons.electric_car;
      case NewsCategory.techCrunch:
        return Icons.devices;
      case NewsCategory.wsj:
        return Icons.business_center;
    }
  }
}

class NewsRepository {
  static const String _apiKey = 'd9d035015645466c9c253b23c1652f98';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> getTopHeadlines({
    String country = 'us',
    String category = 'business',
  }) async {
    final url =
        '$_baseUrl/top-headlines?country=$country&category=$category&apiKey=$_apiKey';
    return _fetchArticles(url);
  }

  Future<List<Article>> getEverything({
    required String query,
    String? from,
    String? to,
    String? sortBy,
    String? domains,
  }) async {
    var url = '$_baseUrl/everything?apiKey=$_apiKey';

    if (query.isNotEmpty) {
      url += '&q=$query';
    }
    if (from != null && from.isNotEmpty) {
      url += '&from=$from';
    }
    if (to != null && to.isNotEmpty) {
      url += '&to=$to';
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      url += '&sortBy=$sortBy';
    }
    if (domains != null && domains.isNotEmpty) {
      url += '&domains=$domains';
    }

    return _fetchArticles(url);
  }

  // Fetch from specific source
  Future<List<Article>> getFromSource(String source) async {
    final url = '$_baseUrl/top-headlines?sources=$source&apiKey=$_apiKey';
    return _fetchArticles(url);
  }

  // Private method to fetch and parse articles
  Future<List<Article>> _fetchArticles(String url) async {
    try {
      if (kDebugMode) {
        print('Fetching from: $url');
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'ok') {
          final articlesJson = data['articles'] as List;
          final articles = articlesJson
              .map(
                (article) => Article.fromJson(article as Map<String, dynamic>),
              )
              .where(
                (article) =>
                    article.title != null && article.title != '[Removed]',
              )
              .toList();

          if (kDebugMode) {
            print('Fetched ${articles.length} articles');
          }
          return articles;
        } else {
          throw Exception('API returned error: ${data['message']}');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your API key.');
      } else if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to load articles: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching articles: $e');
      }
      rethrow;
    }
  }
}
