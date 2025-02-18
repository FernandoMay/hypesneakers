import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String description;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final String category;
  final bool isNew;
  final bool isPopular;
  final double rating;
  final int reviewCount;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.category,
    this.isNew = false,
    this.isPopular = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFavorite = false,
  });

  String get image => images.first;
}

class CartItem {
  final Product product;
  final String size;
  final String color;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.color,
    this.quantity = 1,
  });

  double get total => product.price * quantity;
}

class Category {
  final String id;
  final String name;
  final String image;
  final String description;
  bool isSelected;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    this.isSelected = false,
  });
}

class AppState extends ChangeNotifier {
  User? _user;
  final List<Product> _products = [];
  final List<CartItem> _cart = [];
  final List<Product> _favorites = [];
  bool _isLoading = false;

  User? get user => _user;
  List<Product> get products => List.unmodifiable(_products);
  List<CartItem> get cart => List.unmodifiable(_cart);
  List<Product> get favorites => List.unmodifiable(_favorites);
  bool get isLoading => _isLoading;

  double get cartTotal => _cart.fold(0, (sum, item) => sum + item.total);
  int get cartItemCount => _cart.fold(0, (sum, item) => sum + item.quantity);

  void loadInitialData() {
    _products.addAll([
      Product(
        id: '1',
        name: 'Nike Air Max 270',
        brand: 'Nike',
        price: 150.0,
        description: 'The Nike Air Max 270 delivers visible cushioning under every step.',
        images: [
          'assets/shoe_thumb_1.jpeg',
          'assets/shoe_thumb_2.jpeg',
          'assets/shoe_thumb_3.jpeg',
        ],
        sizes: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11'],
        colors: ['Black', 'White', 'Red'],
        category: 'Running',
        isNew: true,
        isPopular: true,
        rating: 4.8,
        reviewCount: 254,
      ),
      Product(
        id: '2',
        name: 'Nike Air Jordan 1',
        brand: 'Nike',
        price: 180.0,
        description: 'The iconic Air Jordan 1 in a modern interpretation.',
        images: [
          'assets/shoe_thumb_4.jpeg',
          'assets/shoe_thumb_5.jpeg',
          'assets/shoe_thumb_6.jpeg',
        ],
        sizes: ['US 7', 'US 8', 'US 9', 'US 10', 'US 11'],
        colors: ['Black', 'Red', 'White'],
        category: 'Lifestyle',
        isNew: false,
        isPopular: true,
        rating: 4.9,
        reviewCount: 512,
      ),
    ]);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  void addToCart(Product product, String size, String color) {
    final existingItem = _cart.firstWhere(
      (item) =>
          item.product.id == product.id &&
          item.size == size &&
          item.color == color,
      orElse: () => CartItem(
        product: product,
        size: size,
        color: color,
        quantity: 0,
      ),
    );

    if (existingItem.quantity == 0) {
      _cart.add(CartItem(
        product: product,
        size: size,
        color: color,
      ));
    } else {
      existingItem.quantity++;
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cart.remove(item);
    notifyListeners();
  }

  void updateCartItemQuantity(CartItem item, int quantity) {
    if (quantity < 1) {
      removeFromCart(item);
    } else {
      item.quantity = quantity;
      notifyListeners();
    }
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      _favorites.add(product);
    } else {
      _favorites.remove(product);
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final List<String> favoriteIds;
  final List<Address> addresses;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
    List<String>? favoriteIds,
    List<Address>? addresses,
  })  : favoriteIds = favoriteIds ?? [],
        addresses = addresses ?? [];
}

class Address {
  final String id;
  final String name;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.isDefault = false,
  });
}
