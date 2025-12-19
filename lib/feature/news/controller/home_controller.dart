import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bangladesh/feature/news/model/article_model.dart';

class NewsController {
  final NewsRepository _repository = NewsRepository();

  // ==================== STATE ====================
  List<Article> _articles = [];
  List<Article> _filteredArticles = [];
  bool _isLoading = false;
  String? _errorMessage;
  NewsCategory _currentCategory = NewsCategory.topHeadlines;
  String _searchQuery = '';

  Timer? _searchDebounce;

  // ==================== GETTERS ====================
  List<Article> get articles =>
      _searchQuery.isEmpty ? _articles : _filteredArticles;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  NewsCategory get currentCategory => _currentCategory;
  String get searchQuery => _searchQuery;

  // ==================== VIEW CALLBACK ====================
  VoidCallback? onStateChanged;

  void _notifyListeners() {
    onStateChanged?.call();
  }

  // ==================== STATE HELPERS ====================
  void _setLoading(bool value) {
    _isLoading = value;
    _notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    _notifyListeners();
  }

  void _updateArticles(List<Article> newArticles) {
    _articles = newArticles;
    _filteredArticles = newArticles;
    _notifyListeners();
  }

  // ==================== API SEARCH (q) ====================
  void searchArticles(String query) {
    _searchQuery = query.trim();

    _searchDebounce?.cancel();

    // If search cleared → restore category articles
    if (_searchQuery.isEmpty) {
      _filteredArticles = _articles;
      _notifyListeners();
      return;
    }

    // Debounced API call
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      _setLoading(true);
      _setError(null);

      try {
        final results = await _repository.getEverything(
          query: _searchQuery,
          sortBy: 'publishedAt',
        );

        _filteredArticles = results;
      } catch (e) {
        _setError(e.toString());
      } finally {
        _setLoading(false);
        _notifyListeners();
      }
    });
  }

  // ==================== CLEAR SEARCH ====================
  void clearSearch() {
    _searchQuery = '';
    _searchDebounce?.cancel();
    _filteredArticles = _articles;
    _notifyListeners();
  }

  // ==================== CATEGORY FETCH ====================
  Future<void> fetchArticlesByCategory(NewsCategory category) async {
    _currentCategory = category;
    _searchQuery = '';
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
          fetchedArticles = await _repository.getEverything(
            query: 'apple',
            from: _formatDate(yesterday),
            to: _formatDate(yesterday),
            sortBy: 'popularity',
          );
          break;

        case NewsCategory.tesla:
          final lastMonth = DateTime.now().subtract(const Duration(days: 30));
          fetchedArticles = await _repository.getEverything(
            query: 'tesla',
            from: _formatDate(lastMonth),
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

  // ==================== REFRESH ====================
  Future<void> refreshArticles() async {
    await fetchArticlesByCategory(_currentCategory);
  }

  // ==================== HELPERS ====================
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // ==================== DISPOSE ====================
  void dispose() {
    _searchDebounce?.cancel();
    onStateChanged = null;
  }
}
