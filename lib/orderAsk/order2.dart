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

class Order2 extends StatefulWidget {
  //const Order2({Key? key}) : super(key: key);
  final Cart cart;
  final drive = 1500;
  Order2(this.cart);
  @override
  _Order2State createState() => _Order2State();
}

class _Order2State extends State<Order2> {
  final _companyTController = TextEditingController();
  final _nameTController = TextEditingController();
  final _numberTController = TextEditingController();
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

    final double itemHeight = (size.height - kToolbarHeight - 330) / 1;
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
                Column(
                  children: <Widget>[
                    Text(
                      ' بيانات الحوالة',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    TextFormField(
                      controller: _companyTController,
                      decoration: InputDecoration(
                        errorText: validateCompanyT(_companyTController.text),
                        hintText: ' اكتب اسم شركة الصرافة او البنك ',
                        hintStyle: TextStyle(fontSize: 11),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _nameTController,
                      decoration: InputDecoration(
                        errorText: validateNameT(_nameTController.text),
                        hintText: 'اكتب اسم المحول',
                        hintStyle: TextStyle(fontSize: 11),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _numberTController,
                      decoration: InputDecoration(
                        errorText: validateNumberT(_numberTController.text),
                        hintText: 'اكتب رقم الحوالة',
                        hintStyle: TextStyle(fontSize: 11),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
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
                      String companyT = _companyTController.text;
                      String nameT = _nameTController.text;
                      String numberT = _numberTController.text;
                      await orderApi.orderT(cart_id, address, city, amount,
                          companyT, nameT, numberT);

                      if (_companyTController.text.isNotEmpty &&
                          _nameTController.text.isNotEmpty &&
                          _numberTController.text.isNotEmpty) {
                        /* FutureBuilder();*/
                        Navigator.of(context)
                            .push(SlideRight(Page: OrderShowOne(widget.cart)));
                        print('true');
                      } else {
                        print('false');
                      }
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

  String validateCompanyT(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "ادخل اسم شركة الصرافة او البنك*";
  }

  String validateNameT(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "ادخل اسم المحول *";
  }

  String validateNumberT(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "ادخل رقم الحوالة*";
  }
}
