import 'package:bangladesh/feature/news/model/article_model.dart';
import 'package:flutter/material.dart';

class NewsController {
  final NewsRepository _repository = NewsRepository();

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _errorMessage;
  NewsCategory _currentCategory = NewsCategory.topHeadlines;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NewsCategory get currentCategory => _currentCategory;

  VoidCallback? onStateChanged;

  void _notifyListeners() {
    if (onStateChanged != null) {
      onStateChanged!();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    _notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    _notifyListeners();
  }

  void _updateArticles(List<Article> newArticles) {
    _articles = newArticles;
    _notifyListeners();
  }

  Future<void> fetchArticlesByCategory(NewsCategory category) async {
    _currentCategory = category;
    _setError(null);
    _setLoading(true);

    try {
      List<Article> fetchedArticles;

      switch (category) {
        case NewsCategory.topHeadlines:
          fetchedArticles = await _repository.getTopHeadlines(
            country: 'us',
            category: 'business',
          );
          break;

        case NewsCategory.apple:
          final yesterday = DateTime.now().subtract(const Duration(days: 1));
          final dateStr = _formatDate(yesterday);
          fetchedArticles = await _repository.getEverything(
            query: 'apple',
            from: dateStr,
            to: dateStr,
            sortBy: 'popularity',
          );
          break;

        case NewsCategory.tesla:
          final lastMonth = DateTime.now().subtract(const Duration(days: 30));
          final dateStr = _formatDate(lastMonth);
          fetchedArticles = await _repository.getEverything(
            query: 'tesla',
            from: dateStr,
            sortBy: 'publishedAt',
          );
          break;

        case NewsCategory.techCrunch:
          fetchedArticles = await _repository.getFromSource('techcrunch');
          break;

        case NewsCategory.wsj:
          fetchedArticles = await _repository.getEverything(
            query: 'business',
            domains: 'wsj.com',
            sortBy: 'publishedAt',
          );
          break;
      }

      _updateArticles(fetchedArticles);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshArticles() async {
    await fetchArticlesByCategory(_currentCategory);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void dispose() {
    onStateChanged = null;
  }
}
