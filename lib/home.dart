import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'styles.dart';
import 'product.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Category> categories = [
    Category(
      id: '1',
      name: 'Running',
      image: 'assets/shoe_thumb_1.jpeg',
      description: 'High-performance running shoes',
      isSelected: true,
    ),
    Category(
      id: '2',
      name: 'Basketball',
      image: 'assets/shoe_thumb_2.jpeg',
      description: 'Professional basketball shoes',
    ),
    Category(
      id: '3',
      name: 'Lifestyle',
      image: 'assets/shoe_thumb_3.jpeg',
      description: 'Casual and comfortable sneakers',
    ),
    Category(
      id: '4',
      name: 'Training',
      image: 'assets/shoe_thumb_4.jpeg',
      description: 'Versatile training shoes',
    ),
  ];

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.textLight.withOpacity(0.1),
                borderRadius: AppTheme.borderRadius,
              ),
              child: CupertinoTextField(
                placeholder: "Search Products",
                placeholderStyle: AppTextStyles.bodySmall,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    CupertinoIcons.search,
                    color: AppColors.textSecondary,
                  ),
                ),
                decoration: null,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.all(10),
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
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      height: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _categoryCard(categories[index]);
        },
      ),
    );
  }

  Widget _categoryCard(Category category) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            for (var item in categories) {
              item.isSelected = item.id == category.id;
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: category.isSelected ? AppColors.accent : AppColors.cardBackground,
            borderRadius: AppTheme.borderRadius,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                category.image,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: category.isSelected
                    ? AppTextStyles.titleSmall.copyWith(color: AppColors.cardBackground)
                    : AppTextStyles.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      height: 280,
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: appState.products.length,
            itemBuilder: (context, index) {
              final product = appState.products[index];
              return _productCard(product);
            },
          );
        },
      ),
    );
  }

  Widget _productCard(Product product) {
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
        width: 200,
        margin: const EdgeInsets.only(right: 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    product.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.read<AppState>().toggleFavorite(product);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        product.isFavorite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: product.isFavorite
                            ? AppColors.accent
                            : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brand,
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    style: AppTextStyles.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: AppTextStyles.price,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _search(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Categories',
              style: AppTextStyles.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          _categoryWidget(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Featured',
              style: AppTextStyles.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          _productWidget(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
