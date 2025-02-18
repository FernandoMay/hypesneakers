import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'styles.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  String? selectedColor;
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.product.name),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<AppState>().toggleFavorite(widget.product);
          },
          child: Icon(
            widget.product.isFavorite
                ? CupertinoIcons.heart_fill
                : CupertinoIcons.heart,
            color: widget.product.isFavorite
                ? AppColors.accent
                : AppColors.textSecondary,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageGallery(),
                    _buildProductInfo(),
                    _buildSizeSelection(),
                    _buildColorSelection(),
                    _buildDescription(),
                  ],
                ),
              ),
            ),
            _buildAddToCartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.product.images.length,
            onPageChanged: (index) {
              setState(() {
                currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.product.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.product.images.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentImageIndex == entry.key
                        ? AppColors.accent
                        : AppColors.textLight,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.brand,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: AppTextStyles.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.star_fill,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.product.rating.toString(),
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${widget.product.reviewCount})',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Size',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.product.sizes.map((size) {
              final isSelected = selectedSize == size;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSize = size;
                  });
                },
                child: Container(
                  width: 70,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.cardBackground,
                    borderRadius: AppTheme.borderRadius,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.divider,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    size,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.cardBackground
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Color',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.product.colors.map((color) {
              final isSelected = selectedColor == color;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = color;
                  });
                },
                child: Container(
                  width: 70,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accent
                        : AppColors.cardBackground,
                    borderRadius: AppTheme.borderRadius,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.divider,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    color,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isSelected
                          ? AppColors.cardBackground
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: CupertinoButton.filled(
        onPressed: selectedSize == null || selectedColor == null
            ? null
            : () {
                context.read<AppState>().addToCart(
                      widget.product,
                      selectedSize!,
                      selectedColor!,
                    );
                Navigator.pop(context);
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('Success'),
                    content: const Text('Item added to cart'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
        child: const Text('Add to Cart'),
      ),
    );
  }
}
