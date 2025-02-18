import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'home.dart';
import 'styles.dart';
import 'models.dart';

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
            child: _icon(CupertinoIcons.bars, color: AppColors.textSecondary),
          ),
          ClipRRect(
            borderRadius: AppTheme.borderRadius,
            child: Container(
              height: 180.0,
              width: 180.0,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/bmb.jpg",
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = AppColors.textSecondary}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: AppTheme.borderRadius,
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
      ),
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
                style: AppTextStyles.displayMedium,
              ),
              Text(
                isHomePageSelected ? 'Products' : 'Cart',
                style: AppTextStyles.displayLarge,
              ),
            ],
          ),
          const Spacer(),
          !isHomePageSelected
              ? CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    context.read<AppState>().clearCart();
                  },
                  child: Icon(
                    CupertinoIcons.delete,
                    color: AppColors.accent,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
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
    final size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: size.height - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.background,
                      AppColors.background.withOpacity(0.8),
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
                        duration: AppAnimations.fast,
                        switchInCurve: AppAnimations.defaultCurve,
                        switchOutCurve: AppAnimations.defaultCurve,
                        child: isHomePageSelected
                            ? Home(title: 'OG')
                            : const CartPage(),
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
  const CustomBottomNavigationBar({Key? key, required this.onIconPresedCallback})
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
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );
    _yController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

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

  Widget _buildIcon(IconData icon, bool isSelected, int index) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => _handlePressed(index),
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : AppColors.cardBackground,
            borderRadius: AppTheme.borderRadiusLarge,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            color: isSelected ? AppColors.cardBackground : AppColors.textSecondary,
          ),
        ),
      ),
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
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: AppTheme.borderRadiusLarge,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(CupertinoIcons.home, _selectedIndex == 0, 0),
            _buildIcon(CupertinoIcons.search, _selectedIndex == 1, 1),
            _buildIcon(CupertinoIcons.shopping_cart, _selectedIndex == 2, 2),
            _buildIcon(CupertinoIcons.heart, _selectedIndex == 3, 3),
          ],
        ),
      ),
    );
  }
}
