import 'package:flutter/cupertino.dart';
import 'package:hype49sneakers/models.dart';
import 'package:hype49sneakers/styles.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            CupertinoIcons.back,
            color: CupertinoColors.black,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          _icon(isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isLiked
                  ? CupertinoColors.systemRed
                  : CupertinoColors.systemGrey,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          }),
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = CupertinoColors.inactiveGray,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function? onPressed,
  }) {
    return CupertinoButton(
        onPressed: () => onPressed,
        child: Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(padding),
          // margin: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            border: Border.all(
                color: CupertinoColors.inactiveGray,
                style: isOutLine ? BorderStyle.solid : BorderStyle.none),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            color: isOutLine
                ? CupertinoColors.white
                : CupertinoColors.darkBackgroundGray,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8),
                  blurRadius: 5,
                  spreadRadius: 10,
                  offset: Offset(5, 5)),
            ],
          ),
          child: Icon(icon, color: color, size: size),
        ));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          const Text(
            "AIP",
            style: TextStyle(
              fontSize: 160,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Image.asset('assets/show_1.png')
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      // width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
    );
  }

  Widget _thumbnail(String image) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(13)),
      child: AnimatedBuilder(
        animation: animation,
        //  builder: null,
        builder: (context, child) => AnimatedOpacity(
          opacity: animation.value,
          duration: const Duration(milliseconds: 500),
          child: child,
        ),
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 40,
              width: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.systemGrey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                // color: Theme.of(context).backgroundColor,
              ),
              child: Image.asset(image),
            )),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: CupertinoColors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: CupertinoColors.inactiveGray,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "NIKE AIR MAX 200",
                      style: TextStyle(fontSize: 25),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              "\$ ",
                              style: TextStyle(
                                fontSize: 18,
                                color: CupertinoColors.systemRed,
                              ),
                            ),
                            Text(
                              "240",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const <Widget>[
                            Icon(CupertinoIcons.star,
                                color: CupertinoColors.systemYellow, size: 17),
                            Icon(CupertinoIcons.star,
                                color: CupertinoColors.systemYellow, size: 17),
                            Icon(CupertinoIcons.star,
                                color: CupertinoColors.systemYellow, size: 17),
                            Icon(CupertinoIcons.star,
                                color: CupertinoColors.systemYellow, size: 17),
                            Icon(CupertinoIcons.star, size: 17),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _availableSize(),
                const SizedBox(
                  height: 20,
                ),
                _availableColor(),
                const SizedBox(
                  height: 20,
                ),
                _description(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Available Size",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("US 6"),
            _sizeWidget("US 7", isSelected: true),
            _sizeWidget("US 8"),
            _sizeWidget("US 9"),
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text, {bool isSelected = false}) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
                color: CupertinoColors.inactiveGray,
                style: !isSelected ? BorderStyle.solid : BorderStyle.none),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            color: isSelected
                ? CupertinoColors.systemOrange
                : CupertinoTheme.of(context).barBackgroundColor,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isSelected
                  ? CupertinoColors.systemBackground
                  : CupertinoColors.placeholderText,
            ),
          ),
        ));
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Available Size",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(CupertinoColors.systemYellow, isSelected: true),
            const SizedBox(
              width: 30,
            ),
            _colorWidget(CupertinoColors.systemBlue),
            const SizedBox(
              width: 30,
            ),
            _colorWidget(CupertinoColors.black),
            const SizedBox(
              width: 30,
            ),
            _colorWidget(CupertinoColors.systemRed),
            const SizedBox(
              width: 30,
            ),
            _colorWidget(CupertinoColors.activeBlue),
          ],
        )
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      // color: color.withAlpha(150),
      child: isSelected
          ? Icon(
              CupertinoIcons.checkmark_circle,
              color: color,
              size: 18,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(7),
            ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "Available Size",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Text(AppData.description),
      ],
    );
  }

  CupertinoButton _flotingButton() {
    return CupertinoButton.filled(
      onPressed: () {},
      disabledColor: CupertinoColors.activeOrange,
      child: Icon(CupertinoIcons.shopping_cart,
          color: CupertinoTheme.of(context).barBackgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // floatingActionButton: _flotingButton(),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _appBar(),
                      _productImage(),
                      _categoryWidget(),
                    ],
                  ),
                  _detailWidget()
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: _flotingButton(),
            ),
          ],
        ),
      ),
    );
  }
}
