import 'package:flutter/material.dart';
import 'package:generalshops/animaterout.dart';
import 'package:generalshops/api/order_api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/order/orderModel.dart';
import 'package:generalshops/screens/orderShowOne.dart';

class Transfer3 extends StatefulWidget {
  // const Transfer3({Key? key}) : super(key: key);
  final Cart cart;
  Transfer3(this.cart);
  final drive = 1500;
  @override
  _Transfer3State createState() => _Transfer3State();
}

class _Transfer3State extends State<Transfer3> {
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _companyTController = TextEditingController();
  final _nameTController = TextEditingController();
  final _numberTController = TextEditingController();

  OrderApi orderApi = OrderApi();

  Order order;
  @override
  void didUpdateWidget(covariant Transfer3 oldWidget) {
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
          height: 1100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
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
              SizedBox(
                height: 20,
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
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    ' بيانات العنوان ',
                    style: Theme.of(context).textTheme.headline,
                  ),
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
                    height: 15,
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
              SizedBox(
                height: 15,
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
                    String companyT = _companyTController.text;
                    String nameT = _nameTController.text;
                    String numberT = _numberTController.text;

                    await orderApi.orderT(cart_id, address, city, amount,
                        companyT, nameT, numberT);

                    if (_addressController.text.isNotEmpty &&
                        _cityController.text.isNotEmpty &&
                        _companyTController.text.isNotEmpty &&
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
              SizedBox(
                height: 15,
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
