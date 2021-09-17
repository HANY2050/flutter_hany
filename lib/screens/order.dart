import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/order_api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/order/orderModel.dart';
import 'package:generalshops/screens/orderShowOne.dart';

import '../animaterout.dart';

class HomeOrder extends StatefulWidget {
  final Cart cart;

  HomeOrder(this.cart);

  final drive = 1500;

  @override
  _HomeOrderState createState() => _HomeOrderState();
}

class _HomeOrderState extends State<HomeOrder> {
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();

  OrderApi orderApi = OrderApi();

  Order order;
  @override
  void didUpdateWidget(covariant HomeOrder oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('مرحلة تنفيذ الطلب'),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      errorText: validateAddress(_cityController.text),
                      hintText: 'اكتب المدينة',
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
                    height: 30,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      errorText: validateCity(_addressController.text),
                      hintText: 'اكتب العنوان',
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
                    String address = _addressController.text;
                    String city = _cityController.text;
                    await orderApi.order(cart_id, address, city, amount);

                    if (_addressController.text.isNotEmpty &&
                        _cityController.text.isNotEmpty) {
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
        ),
      ),
    );
  }

  String validateAddress(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "ادخل المدينة*";
  }

  String validateCity(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return "ادخل العنوان*";
    return null;
  }
}
