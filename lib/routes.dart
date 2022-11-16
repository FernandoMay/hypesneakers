import 'package:flutter/cupertino.dart';
import 'package:hype49sneakers/base.dart';
import 'package:hype49sneakers/home.dart';
import 'package:hype49sneakers/product.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => const Home(title: 'J&J'),
      '/base': (context) => const Base(title: 'Safe'),
      '/detail': (context) => ProductDetail()
    };
  }
}
