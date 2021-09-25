import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/cart_api.dart';
import 'package:generalshops/modelcart1/cart1.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/screens/screen_login_sigin.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ScreenSizeColor.dart';
import 'cart_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Cart1(),
  ));
}

class SingleProduct extends StatefulWidget {
  final Product product;

  SingleProduct(this.product);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int _value = 1;
  CartApi cartApi = CartApi();
  bool _addingToCart = false;
  bool _addingToFavorite = false;
  Cart1 cart = Cart1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        /* leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),*/
        elevation: 3,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(widget.product.product_title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(cart.count.toString()),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: _drawScreen(context),
      floatingActionButton: FloatingActionButton(
        child: (_addingToCart)
            ? CircularProgressIndicator()
            : Icon(Icons.add_shopping_cart),
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          int userId = pref.getInt('user_id');
          if (userId == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage2()));
          } else if (widget.product.size1 != '0' &&
              widget.product.color1 != '0') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SizeColor(widget.product)));
          } else {
            setState(() {
              _addingToCart = true;
              return ('تم الاضافة الي سبة المشتريات');
            });
            cart.add(widget.product);
            await cartApi.addProductToCart(widget.product.product_id);
            setState(() {
              _addingToCart = false;
            });
          }
          // To Do Add To Cart
        },
      ),
    );
  }

  //Future<void> addProductToCart() async {}

  Widget _drawScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: _drawImageGallery(context),
              ),
              _drawTitle(context),
              _drawDetails(context),
              _drawLain(),
            ],
          ),
        ),
        _drawLain(),
      ],
    );
  }

  Widget _drawImageGallery(BuildContext context) {
    return PageView.builder(
      itemCount: widget.product.images.length,
      itemBuilder: (context, int position) {
        return Container(
          padding: EdgeInsets.all(8),
          child: Image(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              widget.product.featuredImage(),
            ),
          ),
        );
      },
    );
  }

  Widget _drawTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.product.product_title,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  widget.product.size1,
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 16,
                ),
                new Text(
                  "مقدم من  : ",
                  style: Theme.of(context).textTheme.subhead,
                ),
                Text(
                  widget.product.infoShop.info_shop_shop_name,
                  style: Theme.of(context).textTheme.subhead,
                ),
                SizedBox(
                  height: 16,
                ),
                /*  Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Row(
                    children: [
                      Card(
                        child: Container(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (widget.product.size1 != "0")
                                  ? RadioListTile(
                                      value: 1,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size1,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size2 != "0")
                                  ? RadioListTile(
                                      value: 2,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Flexible(
                                        child: Text(
                                          widget.product.size2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size3 != "0")
                                  ? RadioListTile(
                                      value: 3,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size3,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size4 != "0")
                                  ? RadioListTile(
                                      value: 4,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size4,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size5 != "0")
                                  ? RadioListTile(
                                      value: 5,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size5,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (widget.product.size1 != "0")
                                  ? RadioListTile(
                                      value: 1,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size1,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size2 != "0")
                                  ? RadioListTile(
                                      value: 2,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Flexible(
                                        child: Text(
                                          widget.product.size2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size3 != "0")
                                  ? RadioListTile(
                                      value: 3,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size3,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size4 != "0")
                                  ? RadioListTile(
                                      value: 4,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size4,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                              (widget.product.size5 != "0")
                                  ? RadioListTile(
                                      value: 5,
                                      groupValue: _value,
                                      onChanged: (val) {
                                        setState(() {
                                          _value = val;
                                        });
                                      },
                                      title: Text(
                                        widget.product.size5,
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/

                /*  Text(
                  widget.product.productCategory.category_name,
                  style: Theme.of(context).textTheme.subhead,
                ),*/
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '\R.Y ${widget.product.product_price.toString()}',
                  style: Theme.of(context).textTheme.headline,
                ),
                SizedBox(
                  height: 16,
                ),
                (widget.product.product_discount > 0)
                    ? Text(
                        _calculateDescount(),
                        style: Theme.of(context).textTheme.subhead,
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    child: (_addingToFavorite)
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.favorite_border,
                            size: 25,
                            color: (widget.product.tags == null
                                ? Colors.black
                                : Colors.red),
                          ),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      int userId = pref.getInt('user_id');
                      if (userId == null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage2()));
                      } else if (widget.product.size1 != '0' &&
                          widget.product.color1 != '0') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SizeColor(widget.product)));
                      } else {
                        setState(() {
                          _addingToFavorite = true;
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          );
                          return ('تم الاضافة الي سبة المشتريات');
                        });

                        await cartApi
                            .addProductToCart(widget.product.product_id);

                        /* Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          );

                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 25,
                          );*/

                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 25,
                        );

                        setState(() {
                          _addingToFavorite = false;
                        });
                      }
                      // To Do Add To Cart
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.product.product_description,
        style: Theme.of(context).textTheme.display2,
      ),
    );
  }

  String _calculateDescount() {
    double discount = widget.product.product_discount;
    int price = widget.product.product_price;
    return (price * discount).toString();
  }

  Widget _drawLain() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, -44),
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 16),
          padding: EdgeInsets.only(left: 20),
          height: 1,
          color: ScreenUtilities.LightGrey,
        ),
      ),
    );
  }
}
