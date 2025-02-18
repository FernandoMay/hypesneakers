import 'package:flutter/cupertino.dart';
import 'profile/orders_page.dart';
import 'profile/notifications_page.dart';
import 'profile/privacy_page.dart';

class AppRoutes {
  static const String orders = '/orders';
  static const String notifications = '/notifications';
  static const String privacy = '/privacy';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      orders: (context) => const OrdersPage(),
      notifications: (context) => const NotificationsPage(),
      privacy: (context) => const PrivacyPage(),
    };
  }

  static void navigateToOrders(BuildContext context) {
    Navigator.pushNamed(context, orders);
  }

  static void navigateToNotifications(BuildContext context) {
    Navigator.pushNamed(context, notifications);
  }

  static void navigateToPrivacy(BuildContext context) {
    Navigator.pushNamed(context, privacy);
  }
}
