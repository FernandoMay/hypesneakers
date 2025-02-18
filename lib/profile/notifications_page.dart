import 'package:flutter/cupertino.dart';
import '../styles.dart';
import '../services/app_state.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool orderUpdates = true;
  bool promotions = true;
  bool newArrivals = true;
  bool priceDrops = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Notifications'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Push Notifications',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _buildNotificationToggle(
                    'Order Updates',
                    'Get notified about your order status',
                    orderUpdates,
                    (value) => setState(() => orderUpdates = value),
                  ),
                  _buildNotificationToggle(
                    'Promotions',
                    'Receive updates about sales and special offers',
                    promotions,
                    (value) => setState(() => promotions = value),
                  ),
                  _buildNotificationToggle(
                    'New Arrivals',
                    'Be the first to know about new products',
                    newArrivals,
                    (value) => setState(() => newArrivals = value),
                  ),
                  _buildNotificationToggle(
                    'Price Drops',
                    'Get notified when items in your wishlist go on sale',
                    priceDrops,
                    (value) => setState(() => priceDrops = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Notifications',
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Manage your email preferences in your account settings.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Navigate to email preferences
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Email Preferences',
                          style: AppTextStyles.bodyMedium,
                        ),
                        const Icon(
                          CupertinoIcons.chevron_right,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium,
              ),
              CupertinoSwitch(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.accent,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
