import 'package:flutter/foundation.dart';
import 'auth_service.dart';
import 'storage_service.dart';
import '../models.dart';

class AppState extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();
  
  User? _user;
  List<Product> _products = [];
  List<CartItem> _cart = [];
  List<Product> _favorites = [];
  bool _isLoading = false;
  bool _isInitialized = false;

  User? get user => _user;
  List<Product> get products => List.unmodifiable(_products);
  List<CartItem> get cart => List.unmodifiable(_cart);
  List<Product> get favorites => List.unmodifiable(_favorites);
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  bool get isAuthenticated => _user != null;

  double get cartTotal => _cart.fold(0, (sum, item) => sum + item.total);
  int get cartItemCount => _cart.fold(0, (sum, item) => sum + item.quantity);

  AppState() {
    _init();
  }

  Future<void> _init() async {
    _setLoading(true);
    try {
      await _storageService.init();
      await _loadInitialData();
      _listenToAuthChanges();
      _isInitialized = true;
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((firebaseUser) async {
      if (firebaseUser == null) {
        await _handleSignOut();
      } else {
        await _handleSignIn();
      }
      notifyListeners();
    });
  }

  Future<void> _handleSignIn() async {
    _setLoading(true);
    try {
      _user = await _authService.getCurrentUser();
      if (_user != null) {
        await _storageService.saveUser(_user);
        await _loadUserData();
      }
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> _handleSignOut() async {
    _setLoading(true);
    try {
      await _storageService.saveUser(null);
      _user = null;
      _cart.clear();
      _favorites.clear();
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _authService.signInWithEmail(email, password);
  }

  Future<void> signUpWithEmail(String name, String email, String password) async {
    await _authService.signUpWithEmail(name, email, password);
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signInWithApple() async {
    await _authService.signInWithApple();
  }

  Future<void> _loadInitialData() async {
    _products = [
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
      // Add more products here
    ];

    if (_user != null) {
      await _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    if (_user == null) return;

    final favoriteIds = await _storageService.getFavoriteIds();
    _favorites = _products
        .where((product) => favoriteIds.contains(product.id))
        .toList();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> addToCart(Product product, String size, String color) async {
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

    await _storageService.saveCart(_cart);
    notifyListeners();
  }

  Future<void> removeFromCart(CartItem item) async {
    _cart.remove(item);
    await _storageService.saveCart(_cart);
    notifyListeners();
  }

  Future<void> updateCartItemQuantity(CartItem item, int quantity) async {
    if (quantity < 1) {
      await removeFromCart(item);
    } else {
      item.quantity = quantity;
      await _storageService.saveCart(_cart);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(Product product) async {
    if (_user == null) return;

    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      _favorites.add(product);
      _user!.favoriteIds.add(product.id);
    } else {
      _favorites.remove(product);
      _user!.favoriteIds.remove(product.id);
    }

    await _storageService.saveFavoriteIds(_user!.favoriteIds);
    notifyListeners();
  }

  Future<void> clearCart() async {
    _cart.clear();
    await _storageService.saveCart(_cart);
    notifyListeners();
  }

  Future<void> updateUserProfile(String name, String? photoUrl) async {
    if (_user == null) return;

    _setLoading(true);
    try {
      await _authService.updateUserProfile(name, photoUrl);
      _user = await _authService.getCurrentUser();
      await _storageService.saveUser(_user);
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  Future<void> updateUserAddress(Address address) async {
    if (_user == null) return;

    _setLoading(true);
    try {
      await _authService.updateUserAddress(address);
      _user = await _authService.getCurrentUser();
      await _storageService.saveUser(_user);
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }
}
