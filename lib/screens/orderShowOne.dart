import 'package:flutter/material.dart';
import 'package:generalshops/api/order_api.dart';
import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/screens/controllerView.dart';
import 'package:generalshops/screens/home_page.dart';

import '../animaterout.dart';

class OrderShowOne extends StatefulWidget {
  /* final Cart cart;

  OrderShowOne(this.cart);
*/

  final drive = 1500;
  final Cart cart;

  OrderShowOne(this.cart);

  @override
  _OrderShowOneState createState() => _OrderShowOneState();
}

class _OrderShowOneState extends State<OrderShowOne> {
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  OrderApi orderApi = OrderApi();
  CartItem cartItem;
  ProductsApi productsApi = ProductsApi();

  /* var _formKey = GlobalKey<FormState>();
  bool _loading = false;*/
  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(SlideRight(Page: ControllerView()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text('تم تنفيذ الطلب بنجاح'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          result: (Route<dynamic> route) => false,
                        );
                      },
                      icon: Icon(
                        Icons.how_to_reg,
                        size: 50,
                        color: Color(0xFFF33020),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Table(
                      border: TableBorder.all(color: Colors.black),
                      columnWidths: {
                        0: FixedColumnWidth(100.0),
                        1: FixedColumnWidth(100.0),
                        2: FixedColumnWidth(50.0),
                      },
                      children: [
                        for (var item in widget.cart.cartItems)
                          TableRow(children: [
                            Center(
                              child: Text(
                                item.product.product_title,
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                            Center(
                              child: Text(
                                "R.Y ${item.product.product_price.toString()}",
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                            Center(
                              child: Text(
                                item.qty.toString(),
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                          ])
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "اجمالي السلة",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 48),
                        child: Text(
                          "R.Y ${widget.cart.total.toString()}",
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'خدمة التوصيل',
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 63),
                        child: Text(
                          '\R.Y ${widget.drive}',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "الاجمالي الكلي",
                        style: Theme.of(context).textTheme.headline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 37),
                        child: Text(
                          '\R.Y ${widget.drive + widget.cart.total}',
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              /*new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/background.png'),
                      ))),*/

              Container(
                padding: EdgeInsets.all(100),
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
