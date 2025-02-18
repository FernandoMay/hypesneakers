import 'package:flutter/cupertino.dart';
import '../profile/orders_page.dart';
import '../profile/notifications_page.dart';
import '../profile/privacy_page.dart';
import '../profile/addresses_page.dart';

class NavigationService {
  static void navigateToOrders(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const OrdersPage(),
      ),
    );
  }

  static void navigateToAddresses(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const AddressesPage(),
      ),
    );
  }

  static void navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const NotificationsPage(),
      ),
    );
  }

  static void navigateToPrivacy(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => const PrivacyPage(),
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popUntilRoot(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
