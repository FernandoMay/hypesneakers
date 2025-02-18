import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'styles.dart';
import 'product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<Product> _searchResults = [];

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final appState = context.read<AppState>();
    setState(() {
      _searchResults = appState.products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.brand.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Search'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoSearchTextField(
                controller: _searchController,
                onChanged: _performSearch,
                placeholder: 'Search for sneakers...',
                style: AppTextStyles.bodyMedium,
                placeholderStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ),
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 64,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'Search for sneakers'
                                : 'No results found',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                          if (_searchController.text.isEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Try searching by name, brand, or category',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textLight,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];
                        return _buildSearchResultItem(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: AppTheme.borderRadius,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: AppTheme.borderRadiusSmall,
              child: Image.asset(
                product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: AppTextStyles.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price,
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_right,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
