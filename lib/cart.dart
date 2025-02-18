import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'models.dart';
import 'styles.dart';
import 'checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Container(
          padding: AppTheme.padding,
          child: appState.cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.shopping_cart,
                        size: 64,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add some items to get started',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: appState.cart.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(item: appState.cart[index]);
                        },
                      ),
                    ),
                    _buildTotalSection(context, appState),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildTotalSection(BuildContext context, AppState appState) {
    return Container(
      padding: AppTheme.padding,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: AppTheme.borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                '\$${appState.cartTotal.toStringAsFixed(2)}',
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                '\$10.00',
                style: AppTextStyles.titleMedium,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Container(
              height: 1,
              color: AppColors.divider,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.titleMedium,
              ),
              Text(
                '\$${(appState.cartTotal + 10).toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CheckoutPage(),
                  ),
                );
              },
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
              item.product.images[0],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  'Size: ${item.size} • Color: ${item.color}',
                  style: AppTextStyles.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${item.product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.price,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context
                          .read<AppState>()
                          .updateCartItemQuantity(item, item.quantity - 1);
                    },
                    child: Icon(
                      CupertinoIcons.minus_circle,
                      color: AppColors.textLight,
                    ),
                  ),
                  Text(
                    '${item.quantity}',
                    style: AppTextStyles.titleSmall,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context
                          .read<AppState>()
                          .updateCartItemQuantity(item, item.quantity + 1);
                    },
                    child: Icon(
                      CupertinoIcons.plus_circle,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  context.read<AppState>().removeFromCart(item);
                },
                child: Text(
                  'Remove',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
