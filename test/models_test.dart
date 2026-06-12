import 'package:flutter_test/flutter_test.dart';
import 'package:hype49sneakers/models.dart';

void main() {
  group('Product', () {
    test('constructor sets all fields correctly', () {
      final product = Product(
        id: '1',
        name: 'Test Shoe',
        brand: 'Nike',
        price: 150.0,
        description: 'A test shoe',
        images: ['assets/test.png'],
        sizes: ['US 9', 'US 10'],
        colors: ['Black', 'White'],
        category: 'Running',
        isNew: true,
        isPopular: true,
        rating: 4.5,
        reviewCount: 100,
        isFavorite: false,
      );

      expect(product.id, '1');
      expect(product.name, 'Test Shoe');
      expect(product.brand, 'Nike');
      expect(product.price, 150.0);
      expect(product.description, 'A test shoe');
      expect(product.images, ['assets/test.png']);
      expect(product.sizes, ['US 9', 'US 10']);
      expect(product.colors, ['Black', 'White']);
      expect(product.category, 'Running');
      expect(product.isNew, true);
      expect(product.isPopular, true);
      expect(product.rating, 4.5);
      expect(product.reviewCount, 100);
      expect(product.isFavorite, false);
    });

    test('image getter returns first image', () {
      final product = Product(
        id: '2',
        name: 'Test Shoe 2',
        brand: 'Adidas',
        price: 120.0,
        description: 'Another test shoe',
        images: ['assets/img1.png', 'assets/img2.png'],
        sizes: ['US 8'],
        colors: ['Red'],
        category: 'Lifestyle',
      );

      expect(product.image, 'assets/img1.png');
    });

    test('default values are correct', () {
      final product = Product(
        id: '3',
        name: 'Default Shoe',
        brand: 'Puma',
        price: 100.0,
        description: 'Default test',
        images: ['assets/default.png'],
        sizes: ['US 10'],
        colors: ['Blue'],
        category: 'Training',
      );

      expect(product.isNew, false);
      expect(product.isPopular, false);
      expect(product.rating, 0.0);
      expect(product.reviewCount, 0);
      expect(product.isFavorite, false);
    });

    test('isFavorite can be toggled', () {
      final product = Product(
        id: '4',
        name: 'Toggle Shoe',
        brand: 'Nike',
        price: 200.0,
        description: 'For toggle test',
        images: ['assets/toggle.png'],
        sizes: ['US 11'],
        colors: ['Green'],
        category: 'Running',
      );

      expect(product.isFavorite, false);
      product.isFavorite = true;
      expect(product.isFavorite, true);
      product.isFavorite = false;
      expect(product.isFavorite, false);
    });
  });

  group('CartItem', () {
    test('constructor sets fields correctly', () {
      final product = Product(
        id: '1',
        name: 'Test Shoe',
        brand: 'Nike',
        price: 150.0,
        description: 'Test',
        images: ['assets/test.png'],
        sizes: ['US 9'],
        colors: ['Black'],
        category: 'Running',
      );

      final item = CartItem(
        product: product,
        size: 'US 9',
        color: 'Black',
        quantity: 2,
      );

      expect(item.product, product);
      expect(item.size, 'US 9');
      expect(item.color, 'Black');
      expect(item.quantity, 2);
    });

    test('total calculates correctly', () {
      final product = Product(
        id: '1',
        name: 'Test Shoe',
        brand: 'Nike',
        price: 100.0,
        description: 'Test',
        images: ['assets/test.png'],
        sizes: ['US 9'],
        colors: ['Black'],
        category: 'Running',
      );

      final item = CartItem(product: product, size: 'US 9', color: 'Black');
      expect(item.total, 100.0);

      item.quantity = 3;
      expect(item.total, 300.0);
    });

    test('default quantity is 1', () {
      final product = Product(
        id: '1',
        name: 'Test Shoe',
        brand: 'Nike',
        price: 50.0,
        description: 'Test',
        images: ['assets/test.png'],
        sizes: ['US 9'],
        colors: ['Black'],
        category: 'Running',
      );

      final item = CartItem(product: product, size: 'US 9', color: 'Black');
      expect(item.quantity, 1);
    });
  });

  group('Category', () {
    test('constructor sets fields correctly', () {
      final category = Category(
        id: '1',
        name: 'Running',
        image: 'assets/running.png',
        description: 'Running shoes category',
        isSelected: true,
      );

      expect(category.id, '1');
      expect(category.name, 'Running');
      expect(category.image, 'assets/running.png');
      expect(category.description, 'Running shoes category');
      expect(category.isSelected, true);
    });

    test('default isSelected is false', () {
      final category = Category(
        id: '2',
        name: 'Basketball',
        image: 'assets/basketball.png',
        description: 'Basketball shoes',
      );

      expect(category.isSelected, false);
    });
  });

  group('User', () {
    test('constructor sets fields correctly', () {
      final user = User(
        id: 'u1',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://example.com/photo.png',
        favoriteIds: ['1', '2'],
        addresses: [
          Address(
            id: 'a1',
            name: 'Home',
            street: '123 Main St',
            city: 'City',
            state: 'State',
            zipCode: '12345',
            country: 'Country',
            isDefault: true,
          ),
        ],
      );

      expect(user.id, 'u1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.png');
      expect(user.favoriteIds, ['1', '2']);
      expect(user.addresses.length, 1);
    });

    test('default lists are empty', () {
      final user = User(
        id: 'u2',
        email: 'test2@example.com',
        name: 'Test User 2',
      );

      expect(user.favoriteIds, isEmpty);
      expect(user.addresses, isEmpty);
      expect(user.photoUrl, isNull);
    });
  });

  group('Address', () {
    test('constructor sets fields correctly', () {
      final address = Address(
        id: 'a1',
        name: 'Home',
        street: '456 Oak Ave',
        city: 'Springfield',
        state: 'IL',
        zipCode: '62701',
        country: 'USA',
        isDefault: true,
      );

      expect(address.id, 'a1');
      expect(address.name, 'Home');
      expect(address.street, '456 Oak Ave');
      expect(address.city, 'Springfield');
      expect(address.state, 'IL');
      expect(address.zipCode, '62701');
      expect(address.country, 'USA');
      expect(address.isDefault, true);
    });

    test('default isDefault is false', () {
      final address = Address(
        id: 'a2',
        name: 'Work',
        street: '789 Elm St',
        city: 'Chicago',
        state: 'IL',
        zipCode: '60601',
        country: 'USA',
      );

      expect(address.isDefault, false);
    });
  });
}
