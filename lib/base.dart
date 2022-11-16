import 'package:flutter/material.dart';
import 'package:hype49sneakers/cart.dart';
import 'package:hype49sneakers/home.dart';
import 'package:hype49sneakers/styles.dart';
import 'dart:math' as math;

class Base extends StatefulWidget {
  const Base({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  bool isHomePageSelected = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RotatedBox(
            quarterTurns: 4,
            child: _icon(Icons.sort, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 180.0,
              width: 180.0,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset(
                "assets/bmb.jpg",
              ),
            ),
          )
          // .ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: Theme.of(context).backgroundColor,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
      // )
      // .ripple(
      //   () {},
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(13),
      //   ),
    );
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isHomePageSelected ? 'Our' : 'Shopping',
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  isHomePageSelected ? 'Products' : 'Cart',
                  style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.delete_outline,
                      color: LightColor.orange,
                    ),
                  )
                // .ripple(
                //   () {},
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(13),
                //   ),
                // )
                : const SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        isHomePageSelected = true;
      });
    } else {
      setState(() {
        isHomePageSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    _title(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: isHomePageSelected
                            ? Home(
                                title: 'OG',
                              )
                            : const Align(
                                alignment: Alignment.topCenter,
                                child: Cart(),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onIconPresedCallback;
  const CustomBottomNavigationBar(
      {Key? key, required this.onIconPresedCallback})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonsWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonsWidth) / 2;
    return startX +
        index.toDouble() * buttonsWidth / buttonCount +
        buttonsWidth / (buttonCount * 2.0);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _icon(IconData icon, bool isEnable, int index) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        onTap: () {
          _handlePressed(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          alignment: isEnable ? Alignment.topCenter : Alignment.center,
          child: AnimatedContainer(
              height: isEnable ? 40 : 20,
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isEnable ? LightColor.orange : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: isEnable ? const Color(0xfffeece2) : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(5, 5),
                    ),
                  ],
                  shape: BoxShape.circle),
              child: Opacity(
                opacity: isEnable ? _yController.value : 1,
                child: Icon(icon,
                    color: isEnable
                        ? LightColor.background
                        : Theme.of(context).iconTheme.color),
              )),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          Theme.of(context).backgroundColor),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400.0;
    }
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPresedCallback(index);
    setState(() {
      _selectedIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 620));
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _yController.animateTo(1.0,
            duration: const Duration(milliseconds: 1200));
      },
    );
    _yController.animateTo(0.0, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    const height = 60.0;
    return Container(
      width: appSize.width,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _icon(Icons.home, _selectedIndex == 0, 0),
                _icon(Icons.search, _selectedIndex == 1, 1),
                _icon(Icons.card_travel, _selectedIndex == 2, 2),
                _icon(Icons.favorite_border, _selectedIndex == 3, 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundCurvePainter extends CustomPainter {
  static const _radiusTop = 50.0;
  static const _radiusBottom = 30.0;
  static const _horizontalControlTop = 0.6;
  static const _horizontalControlBottom = 0.5;
  static const _pointControlTop = 0.35;
  static const _pointControlBottom = 0.85;
  static const _topY = -60.0;
  static const _bottomY = 0.0;
  static const _topDistance = 0.0;
  static const _bottomDistance = 10.0;

  final double _x;
  final double _normalizedY;
  final Color _color;

  BackgroundCurvePainter(double x, double normalizedY, Color color)
      : _x = x,
        _normalizedY = normalizedY,
        _color = color;

  @override
  void paint(canvas, size) {
    // Paint two cubic bezier curves using various linear interpolations based off of the `_normalizedY` value
    final norm = const LinearPointCurve(0.5, 2.0).transform(_normalizedY) / 5;

    final radius =
        Tween<double>(begin: _radiusTop, end: _radiusBottom).transform(norm);
    // Point colinear to the top edge of the background pane
    final anchorControlOffset = Tween<double>(
            begin: radius * _horizontalControlTop,
            end: radius * _horizontalControlBottom)
        .transform(const LinearPointCurve(0.5, 0.75).transform(norm));
    // Point that slides up and down depending on distance for the target x position
    final dipControlOffset = Tween<double>(
            begin: radius * _pointControlTop, end: radius * _pointControlBottom)
        .transform(const LinearPointCurve(0.5, 0.8).transform(norm));
    final y = Tween<double>(begin: _topY, end: _bottomY)
        .transform(const LinearPointCurve(0.2, 0.7).transform(norm));
    final dist = Tween<double>(begin: _topDistance, end: _bottomDistance)
        .transform(const LinearPointCurve(0.5, 0.0).transform(norm));
    final x0 = _x - dist / 2;
    final x1 = _x + dist / 2;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(x0 - radius, 0)
      ..cubicTo(
          x0 - radius + anchorControlOffset, 0, x0 - dipControlOffset, y, x0, y)
      ..lineTo(x1, y)
      ..cubicTo(x1 + dipControlOffset, y, x1 + radius - anchorControlOffset, 0,
          x1 + radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    final paint = Paint()..color = _color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BackgroundCurvePainter oldDelegate) {
    return _x != oldDelegate._x ||
        _normalizedY != oldDelegate._normalizedY ||
        _color != oldDelegate._color;
  }
}

class CenteredElasticOutCurve extends Curve {
  final double period;

  const CenteredElasticOutCurve([this.period = 0.4]);

  @override
  double transform(double x) {
    // Bascially just a slightly modified version of the built in ElasticOutCurve
    return math.pow(2.0, -10.0 * x) * math.sin(x * 2.0 * math.pi / period) +
        0.5;
  }
}

class CenteredElasticInCurve extends Curve {
  final double period;

  const CenteredElasticInCurve([this.period = 0.4]);

  @override
  double transform(double x) {
    // Bascially just a slightly modified version of the built in ElasticInCurve
    return -math.pow(2.0, 10.0 * (x - 1.0)) *
            math.sin((x - 1.0) * 2.0 * math.pi / period) +
        0.5;
  }
}

class LinearPointCurve extends Curve {
  final double pIn;
  final double pOut;

  const LinearPointCurve(this.pIn, this.pOut);

  @override
  double transform(double x) {
    // Just a simple bit of linear interpolation math
    final lowerScale = pOut / pIn;
    final upperScale = (1.0 - pOut) / (1.0 - pIn);
    final upperOffset = 1.0 - upperScale;
    return x < pIn ? x * lowerScale : x * upperScale + upperOffset;
  }
}
