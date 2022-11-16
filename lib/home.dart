import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:hype49sneakers/models.dart';
import 'package:hype49sneakers/styles.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: LightColor.background,
          boxShadow: AppTheme.shadow),
      child: Icon(
        icon,
        color: color,
      ),
      // ).
      // ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppData.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductIcon(
            model: AppData.categoryList[index],
            onSelected: (model) {
              setState(() {
                for (var item in AppData.categoryList) {
                  item.isSelected = false;
                }
                model.isSelected = true;
              });
            },
          );
        },
      ),
    );
  }

  Widget _productWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullWidth(context) * .7,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 4 / 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 20),
        padding: const EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        itemCount: AppData.productList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: AppData.productList[index],
            onSelected: (model) {
              setState(() {
                for (var item in AppData.productList) {
                  item.isSelected = false;
                }
                model.isSelected = true;
              });
            },
          );
        },
      ),
    );
  }

  Widget _search() {
    return Container(
      margin: AppTheme.padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: LightColor.lightGrey.withAlpha(100),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: CupertinoTextField(
                  placeholder: "Search Products",
                  placeholderStyle: const TextStyle(fontSize: 12),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 0, top: 5),
                  prefix: Icon(CupertinoIcons.search,
                      color: CupertinoColors.black.withOpacity(0.64))),
            ),
          ),
          const SizedBox(width: 20),
          _icon(CupertinoIcons.list_dash, color: CupertinoColors.black)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 210,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _search(),
            _categoryWidget(),
            _productWidget(),
          ],
        ),
      ),
    );
  }
}

class ProductIcon extends StatelessWidget {
  final ValueChanged<Category> onSelected;
  final Category model;
  const ProductIcon({Key? key, required this.model, required this.onSelected})
      : super(key: key);

  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => onSelected(model),
      child: Container(
        padding: AppTheme.hPadding,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color:
              model.isSelected ? LightColor.background : CupertinoColors.white,
          border: Border.all(
            color: model.isSelected ? LightColor.orange : LightColor.grey,
            width: model.isSelected ? 2 : 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: model.isSelected
                  ? const Color(0xfffbf2ef)
                  : CupertinoColors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            model.image != null ? Image.asset(model.image) : const SizedBox(),
            model.name == null
                ? Container()
                : Container(
                    child: Text(
                      model.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<Product> onSelected;
  const ProductCard({Key? key, required this.product, required this.onSelected})
      : super(key: key);

//   @override
//   _ProductCardState createState() => _ProductCardState();
// }

// class _ProductCardState extends State<ProductCard> {
//   Product product;
//   @override
//   void initState() {
//     product = widget.product;
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/detail');
        onSelected(product);
      },
      child: Container(
          decoration: const BoxDecoration(
            color: LightColor.background,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: !product.isSelected ? 20 : 0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 0,
                  child: CupertinoButton(
                    child: Icon(
                      product.isliked
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: product.isliked
                          ? LightColor.red
                          : LightColor.iconColor,
                    ),
                    onPressed: () {},
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: product.isSelected ? 15 : 0),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: LightColor.orange.withAlpha(40),
                            ),
                          ),
                          Image.asset(product.image)
                        ],
                      ),
                    ),
                    // SizedBox(height: 5),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: product.isSelected ? 16 : 14,
                      ),
                    ),
                    Text(
                      product.category,
                      style: TextStyle(
                        fontSize: product.isSelected ? 14 : 12,
                        color: LightColor.orange,
                      ),
                    ),
                    Text(
                      product.price.toString(),
                      style: TextStyle(
                        fontSize: product.isSelected ? 18 : 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
