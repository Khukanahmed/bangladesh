import 'package:bangladesh/feature/news/controller/home_controller.dart';
import 'package:bangladesh/feature/news/model/article_model.dart';
import 'package:bangladesh/feature/news/widgets/article_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../widgets/article_card.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late final NewsController _controller;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = NewsController();

    _controller.onStateChanged = () {
      if (mounted) {
        setState(() {});
      }
    };

    _controller.fetchArticlesByCategory(NewsCategory.topHeadlines);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showCategoryMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: NewsCategory.values.map((category) {
          final isSelected = category == _controller.currentCategory;
          return ListTile(
            leading: Icon(
              category.icon,
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(
              category.displayName,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
            ),
            trailing: isSelected ? const Icon(Icons.check) : null,
            onTap: () {
              Navigator.pop(context);
              _controller.fetchArticlesByCategory(category);
            },
          );
        }).toList(),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _controller.clearSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search articles...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                onChanged: (value) => _controller.searchArticles(value),
              )
            : Text(
                _controller.currentCategory.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
            tooltip: _isSearching ? 'Close Search' : 'Search',
          ),
          if (!_isSearching) ...[
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _controller.refreshArticles(),
              tooltip: 'Refresh',
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showCategoryMenu,
              tooltip: 'Select Category',
            ),
          ],
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Loading state
    if (_controller.isLoading && _controller.articles.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const ArticleShimmer();
        },
      );
    }

    // Error state
    if (_controller.errorMessage != null && _controller.articles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _controller.errorMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _controller.refreshArticles(),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    // Empty state
    if (_controller.articles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _controller.searchQuery.isNotEmpty
                  ? Icons.search_off
                  : Icons.article_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              _controller.searchQuery.isNotEmpty
                  ? 'No results found'
                  : 'No articles found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _controller.searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'Try selecting a different category',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _controller.refreshArticles,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _controller.articles.length,
        itemBuilder: (context, index) {
          final article = _controller.articles[index];
          return ArticleCard(article: article);
        },
      ),
    );
  }
}
