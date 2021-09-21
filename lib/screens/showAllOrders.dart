import 'package:flutter/material.dart';
import 'package:generalshops/api/order_api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/order/orderModel.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/screens/utilities/helperswidgets.dart';

class OrdersAll extends StatefulWidget {
  final drive = 1500;
  @override
  _OrdersAllState createState() => _OrdersAllState();
}

class _OrdersAllState extends State<OrdersAll>
    with AutomaticKeepAliveClientMixin<OrdersAll> {
  Product product;

  Order order;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('طلباتي'),
      ),
      body: FutureBuilder<List<Order>>(
        future: OrderApi().fetchO(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              color: Colors.white54,
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, int i) {
                    //Text(snapshot.data[i].user_id);
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
                              Padding(padding: EdgeInsets.only(left: 95)),
                              Text(
                                'رقم الطلب',
                                style: Theme.of(context).textTheme.headline,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                snapshot.data[i].user_order.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 90)),
                              Text(
                                snapshot.data[i].created_at,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 8),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 22)),
                              Text(
                                'المدينة  :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                snapshot.data[i].city,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 22)),
                              Text(
                                'العنوان  :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  snapshot.data[i].address,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Table(
                              border: TableBorder.all(color: Colors.black),
                              columnWidths: {
                                0: FixedColumnWidth(100.0),
                                1: FixedColumnWidth(100.0),
                                2: FixedColumnWidth(50.0),
                              },
                              children: [
                                for (var item in snapshot.data[i].cartItems)
                                  TableRow(children: [
                                    Center(
                                      child: Text(
                                        item.product.product_title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "R.Y ${item.product.product_price.toString()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        item.qty.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ]),
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 35)),
                              Text(
                                'إجمالي المشتريات  : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "R.Y ${snapshot.data[i].total}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 35)),
                              Text(
                                'خدمة التوصيل      : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "R.Y ${widget.drive}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 35)),
                              Text(
                                'الإجمالي الكلي       : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "R.Y ${snapshot.data[i].amount}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(left: 0)),
                              Text(
                                'طريقة الدفع  :',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 10),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                snapshot.data[i].typeBay,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "لا توجد طلبات ",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            );
          }
          return loading();
        },
      ),
      /*body: FutureBuilder<List<Cart>>(
        future: OrderApi().fetchO(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Text(
                        snapshot.data[i].cartItems.last.product.product_title);
                    // Text(snapshot.data[i].info_shop_image_profile);
                  }),
            );
          } else if (snapshot.hasError) {
            return Text("ssgsg");
          }
          return CircularProgressIndicator();
        },
      ),*/
    );
  }

  Widget _drawProductRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cartItem.product.product_title),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\R.Y  ${cartItem.product.product_price.toString()}',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(cartItem.product.featuredImage()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text(cartItem.qty.toString()),

              /* IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi.DeleteOneCarts(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
