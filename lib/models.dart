class Product {
  int id;
  String name;
  String category;
  String image;
  double price;
  bool isliked;
  bool isSelected;
  Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.isliked,
      this.isSelected = false,
      required this.image});
}

class Category {
  int id;
  String name;
  String image;
  bool isSelected;
  Category(
      {required this.id,
      required this.name,
      this.isSelected = false,
      required this.image});
}

class AppData {
  static List<Product> productList = [
    Product(
        id: 5,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shoe_thumb_5.jpeg',
        category: "Trending Now"),
    Product(
        id: 6,
        name: 'Nike Air Max 97',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_thumb_6.jpeg',
        category: "Trending Now"),
    Product(
        id: 7,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shoe_thumb_7.jpeg',
        category: "Trending Now"),
    Product(
        id: 8,
        name: 'Nike Air Max 98',
        price: 210.00,
        isliked: false,
        image: 'assets/jacket.jpeg',
        category: "Trending Now"),
    Product(
        id: 9,
        name: 'Nike Air Max 99',
        price: 290.00,
        isliked: false,
        image: 'assets/watch.jpeg',
        category: "Trending Now"),
  ];
  static List<Product> cartList = [
    Product(
        id: 1,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shoe_thumb_1.jpeg',
        category: "Trending Now"),
    Product(
        id: 2,
        name: 'Nike Air Max 97',
        price: 190.00,
        isliked: false,
        image: 'assets/shoe_thumb_2.jpeg',
        category: "Trending Now"),
    Product(
        id: 3,
        name: 'Nike Air Max 92607',
        price: 220.00,
        isliked: false,
        image: 'assets/shoe_thumb_3.jpeg',
        category: "Trending Now"),
    Product(
        id: 4,
        name: 'Nike Air Max 200',
        price: 240.00,
        isSelected: true,
        isliked: false,
        image: 'assets/shoe_thumb_4.jpeg',
        category: "Trending Now"),
    // Product(
    //     id:1,
    //     name: 'Nike Air Max 97',
    //     price: 190.00,
    //     isliked: false,
    //     image: 'assets/small_tilt_shoe_2.jpeg',
    //     category: "Trending Now"),
  ];
  static List<Category> categoryList = [
    // Category(),
    Category(
        id: 1,
        name: "Sneakers",
        image: 'assets/shoe_thumb_6.jpeg',
        isSelected: true),
    Category(id: 2, name: "Jacket", image: 'assets/jacket.jpeg'),
    Category(id: 3, name: "Watch", image: 'assets/watch.jpeg'),
    Category(id: 4, name: "Watch", image: 'assets/watch.jpeg'),
  ];
  static List<String> showThumbnailList = [
    "assets/shoe_thumb_5.jpeg",
    "assets/shoe_thumb_1.jpeg",
    "assets/shoe_thumb_4.jpeg",
    "assets/shoe_thumb_3.jpeg",
  ];
  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
