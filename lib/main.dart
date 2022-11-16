import 'package:flutter/cupertino.dart';
import 'package:hype49sneakers/base.dart';
import 'package:hype49sneakers/product.dart';
import 'package:hype49sneakers/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hype49 Sneakers',
      theme: CupertinoTheme.of(context).copyWith(
        primaryColor: CupertinoColors.activeGreen,
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ProductDetail());
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => const Base(
                    title: 'Home',
                  ));
        }
      },
      initialRoute: "/base",
    );
  }
}

class CustomRoute<T> extends CupertinoPageRoute<T> {
  CustomRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == "base") {
      return child;
    }
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
