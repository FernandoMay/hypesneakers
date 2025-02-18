import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models.dart';

class StorageService {
  static const String _cartKey = 'cart';
  static const String _favoritesKey = 'favorites';
  static const String _userKey = 'user';
  static final StorageService _instance = StorageService._internal();
  late SharedPreferences _prefs;

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveCart(List<CartItem> cart) async {
    final cartData = cart.map((item) => {
      'productId': item.product.id,
      'size': item.size,
      'color': item.color,
      'quantity': item.quantity,
    }).toList();
    await _prefs.setString(_cartKey, json.encode(cartData));
  }

  Future<List<String>> getFavoriteIds() async {
    final favorites = _prefs.getStringList(_favoritesKey);
    return favorites ?? [];
  }

  Future<void> saveFavoriteIds(List<String> favoriteIds) async {
    await _prefs.setStringList(_favoritesKey, favoriteIds);
  }

  Future<void> saveUser(User? user) async {
    if (user == null) {
      await _prefs.remove(_userKey);
      return;
    }

    final userData = {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'photoUrl': user.photoUrl,
      'favoriteIds': user.favoriteIds,
      'addresses': user.addresses.map((addr) => {
        'id': addr.id,
        'name': addr.name,
        'street': addr.street,
        'city': addr.city,
        'state': addr.state,
        'zipCode': addr.zipCode,
        'country': addr.country,
        'isDefault': addr.isDefault,
      }).toList(),
    };

    await _prefs.setString(_userKey, json.encode(userData));
  }

  Future<User?> getUser() async {
    final userStr = _prefs.getString(_userKey);
    if (userStr == null) return null;

    final userData = json.decode(userStr) as Map<String, dynamic>;
    return User(
      id: userData['id'],
      email: userData['email'],
      name: userData['name'],
      photoUrl: userData['photoUrl'],
      favoriteIds: List<String>.from(userData['favoriteIds']),
      addresses: (userData['addresses'] as List)
          .map((addr) => Address(
                id: addr['id'],
                name: addr['name'],
                street: addr['street'],
                city: addr['city'],
                state: addr['state'],
                zipCode: addr['zipCode'],
                country: addr['country'],
                isDefault: addr['isDefault'],
              ))
          .toList(),
    );
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
