import 'package:flutter/material.dart';
import 'package:generalshops/api/order_api.dart';
import 'package:generalshops/api/user_Api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/customer/user.dart';
import 'package:generalshops/order/orderModel.dart';
import 'package:generalshops/screens/orderShowOne.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../animaterout.dart';

class Order1 extends StatefulWidget {
  //const Order1({Key? key}) : super(key: key);
  final Cart cart;
  final drive = 1500;
  Order1(this.cart);
  @override
  _Order1State createState() => _Order1State();
}

class _Order1State extends State<Order1> {
  OrderApi orderApi = OrderApi();

  Order order;

  ScreenConfig screenConfig;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<User> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  void initState() {
    super.initState();
    UserApi().fetchUser().then((dataFormServer) {
      setState(() {
        data = dataFormServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    screenConfig = ScreenConfig(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final double itemHeight = (size.height - kToolbarHeight - 400) / 1;
    final double itemWidth = size.width / 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(' مرحلة تنفيذ الطلب'),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.only(top: 10),
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(data.length, (index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          "اجمالي السلة",
                          style: Theme.of(context).textTheme.headline,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 48),
                          child: Text(
                            '\R.Y ${widget.cart.total.toString()}',
                            style: Theme.of(context).textTheme.headline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "سعر التوصيل",
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
                Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () async {
                      double amount = widget.cart.total + widget.drive;
                      String cart_id = widget.cart.id.toString();
                      String address = data[index].address;
                      String city = data[index].city;
                      await orderApi.order(cart_id, address, city, amount);

                      /* FutureBuilder();*/
                      Navigator.of(context)
                          .push(SlideRight(Page: OrderShowOne(widget.cart)));
                      print('true');
                    },
                    color: Color(0xFFB41305),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      'تنفيذ الطلب',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
                  height: 40,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
