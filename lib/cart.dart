import 'package:flutter/cupertino.dart';
import 'package:hype49sneakers/models.dart';
import 'package:hype49sneakers/styles.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  Widget _cartItems() {
    return Column(children: AppData.cartList.map((x) => _item(x)).toList());
  }

  Widget _item(Product model) {
    return Container(
      height: 80,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.2,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  bottom: -20,
                  child: Image.asset(model.image),
                )
              ],
            ),
          ),
          Expanded(
              child: CupertinoNavigationBar(
                  leading: Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  middle: Row(
                    children: <Widget>[
                      const Text(
                        '\$ ',
                        style: TextStyle(
                          color: LightColor.red,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'x${model.id}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget _price() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${AppData.cartList.length} Items',
          style: const TextStyle(
            color: LightColor.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '\$${getPrice()}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () {},

      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all(
      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   ),
      disabledColor: CupertinoColors.systemOrange,
      // ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4),
        width: AppTheme.fullWidth(context) * .75,
        child: const Text(
          'Next',
          style: TextStyle(
            color: LightColor.background,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  double getPrice() {
    double price = 0;
    for (var x in AppData.cartList) {
      price += x.price * x.id;
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.padding,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _cartItems(),
            Container(
              width: 1,
              height: 70,
              padding: const EdgeInsets.all(8.0),
            ),
            _price(),
            const SizedBox(height: 30),
            _submitButton(context),
          ],
        ),
      ),
    );
  }
}
