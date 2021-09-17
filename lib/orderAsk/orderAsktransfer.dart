import 'package:flutter/material.dart';
import 'package:generalshops/animaterout.dart';
import 'package:generalshops/api/user_Api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/customer/user.dart';
import 'package:generalshops/orderAsk/orderAskTransfer3.dart';
import 'package:generalshops/screens/order.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderAskTransfer extends StatefulWidget {
  //const OrderAskTransfer({Key? key}) : super(key: key);
  final Cart cart;
  OrderAskTransfer(this.cart);
  @override
  _OrderAskTransferState createState() => _OrderAskTransferState();
}

class _OrderAskTransferState extends State<OrderAskTransfer> {
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
        title: Text(
          'طريقة الدفع',
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.only(top: 10),
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(data.length, (index) {
          return Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              subtitle: Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Container(
                    width: 50,
                    height: 20,
                  ),
                ),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 6)),
                    Text(
                      '${data[index].first_name}  !!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        'اختر طريقة الدفع ؟ ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    _gotoSingleProduct(widget.cart, context);
                  },
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'الدفع عند الاستلام ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 5,
                ),
                MaterialButton(
                  onPressed: () {
                    _gotoSingleProduct3(widget.cart, context);
                  },
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    'الدفع عبر حواله',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFFF6C536),
                    ),
                  ),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }

  void _gotoSingleProduct(Cart cart, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: HomeOrder(cart)));
  }

  void _gotoSingleProduct3(Cart cart, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: Transfer3(cart)));
  }
}
