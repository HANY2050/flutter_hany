import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/exceptions/exceptions.dart';

class Order {
  int id;
  int user_order;
  String user_id;
  String cart_id;
  String amount;
  String address;
  String city;
  String companyT;
  String nameT;
  String numberT;
  String typeBay;

  List<CartItem> cartItems;

  double total;
  String created_at;
  Order(
    this.user_id,
    this.cart_id,
    this.amount,
    this.address,
    this.city,
    this.cartItems,
    this.id,
    this.total,
    this.user_order,
    this.created_at,
    this.companyT,
    this.numberT,
    this.nameT,
    this.typeBay,
  );

  Order.fromJson(Map<String, dynamic> jsonObject) {
    assert(jsonObject['user_order'] != null, 'order user_order is null');
    assert(jsonObject['user_id'] != null, 'order user_id is null');
    assert(jsonObject['cart_id'] != null, 'order cart_id is null');
    assert(jsonObject['amount'] != null, 'order amount is null');
    assert(jsonObject['address'] != null, 'order address is null');
    assert(jsonObject['city'] != null, ' order city is null');
    assert(jsonObject['created_at'] != null, ' order created_at is null');
    assert(jsonObject['companyT'] != null, ' order companyT is null');
    assert(jsonObject['numberT'] != null, ' order numberT is null');
    assert(jsonObject['nameT'] != null, ' order nameT is null');
    assert(jsonObject['typeBay'] != null, ' order typeBay is null');

    if (jsonObject['user_order'] == null) {
      throw PropertyIsRequired('order user_order');
    }

    if (jsonObject['user_id'] == null) {
      throw PropertyIsRequired('order UserID');
    }
    if (jsonObject['cart_id'] == null) {
      throw PropertyIsRequired('order cart_id');
    }
    if (jsonObject['address'] == null) {
      throw PropertyIsRequired('order address');
    }
    if (jsonObject['amount'] == null) {
      throw PropertyIsRequired('order amount');
    }
    if (jsonObject['city'] == null) {
      throw PropertyIsRequired('order city');
    }
    if (jsonObject['created_at'] == null) {
      throw PropertyIsRequired('order created_at');
    }

    if (jsonObject['companyT'] == null) {
      throw PropertyIsRequired('order companyT');
    }
    if (jsonObject['numberT'] == null) {
      throw PropertyIsRequired('order numberT');
    }
    if (jsonObject['nameT'] == null) {
      throw PropertyIsRequired('order nameT');
    }
    if (jsonObject['typeBay'] == null) {
      throw PropertyIsRequired('order typeBay');
    }

    //this.id = jsonObject['id'];
    this.user_order = jsonObject['user_order'];
    this.user_id = jsonObject['user_id'];
    this.cart_id = jsonObject['cart_id'];
    this.address = jsonObject['address'];
    this.city = jsonObject['city'];
    this.amount = jsonObject['amount'];
    this.created_at = jsonObject['created_at'];
    this.companyT = jsonObject['companyT'];
    this.nameT = jsonObject['nameT'];
    this.numberT = jsonObject['numberT'];
    this.typeBay = jsonObject['typeBay'];

    //this.cartItem = jsonObject['cartItem'];
    //this.cart = jsonObject['cart'];
    cartItems = [];
    var items = jsonObject['cart_items'];

    for (var item in items) {
      cartItems.add(CartItem.fromJson(item));
    }

    this.id = jsonObject['id'];
    this.total = double.tryParse(jsonObject['total']);
    //this.cart_items = Cart.fromJson(jsonObject['cart_items']);
    // this.cartItem = CartItem.fromJson(jsonObject['cartItem']);
  }
}
