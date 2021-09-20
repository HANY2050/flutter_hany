import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generalshops/api/helpers_api.dart';
import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/screens/allProduct.dart';
import 'package:generalshops/screens/productView.dart';
import 'package:generalshops/screens/search.dart';
import 'package:generalshops/screens/showAllOrders.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:generalshops/screens/utilities/helperswidgets.dart';
import 'package:generalshops/screens/utilities/size_config.dart';

import '../animaterout.dart';
import 'allCategories.dart';
import 'cart_screen.dart';
import 'infoShops.dart';

class HomeView extends StatefulWidget {
  //const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  //var List = HelpersApi().fetchCategories();
  //final List<Catog>
  // ScreenConfig screenConfig = ScreenConfig();
  bool isLoading = false;
  ScreenConfig screenConfig;
  List<ProductCategory> names = List();
  List<Product> product = List();

  void initState() {
    if (isLoading) return;
    setState(() => isLoading = true);

    super.initState();
    HelpersApi().fetchCategories(1).then((dataFormServer) {
      setState(() {
        names = dataFormServer;
      });
    });
    setState(() {});
    ProductsApi().fetchProducts(1).then((dataFormServer) {
      setState(() {
        product = dataFormServer;
      });
    });
    Future.delayed(Duration(seconds: 5));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenConfig = ScreenConfig(context);
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    // print(height);
    // print(size);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  Text("معلومات المستخدم"),
                  Text("معلومات المستخدم"),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
            ListTile(
              title: Text('سلة المشتريات'),
              leading: Icon(Icons.card_travel),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              title: Text('طلباتي'),
              leading: Icon(Icons.calendar_today_outlined),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrdersAll()));
              },
            ),
            ListTile(
              title: Text('المتاجر'),
              leading: Icon(Icons.domain_sharp),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeShop()));
              },
            ),
            ListTile(
              title: Text('خاصية البحث'),
              leading: Icon(Icons.search),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeSearch()));
              },
            ),
            /*   ListTile(
              title: Text('المفضلة'),
              leading: Icon(Icons.favorite),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Favorite()));
              },
            ),*/
            ListTile(
              title: Text('اتصل بنا'),
              leading: Icon(Icons.phone_in_talk_outlined),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                /* Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderAskTransfer()));*/
              },
            ),
            ListTile(
              title: Text('معلومات عنا'),
              leading: Icon(Icons.info_outline),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 1),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeSearch()));
              },
            ),
          ),
        ],
        centerTitle: true,
        elevation: 2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'بيوتي ستيشن',

          // ignore: deprecated_member_use
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            children: [
              FutureBuilder(
                future: HelpersApi().fetchCategories(1),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductCategory>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _searchesTextFormFild();
                      break;
                    case ConnectionState.waiting:
                      // return _showLoading();
                      break;

                    case ConnectionState.done:
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return error(snapshot.error.toString());
                      } else {
                        if (!snapshot.hasData) {
                          return error("لا يوجد عروض");
                        } else {
                          return _searchesTextFormFild();
                        }
                      }
                      break;
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الأقسام',
                    // style: Theme.of(context).textTheme.subhead,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllCategories()));
                    },
                    child: Text(
                      'عرض الكل',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              FutureBuilder(
                future: HelpersApi().fetchCategories(1),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductCategory>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _ListViewCategory();
                      break;
                    case ConnectionState.waiting:
                      return loading();
                      break;

                    case ConnectionState.done:
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return error(snapshot.error.toString());
                      } else {
                        if (!snapshot.hasData) {
                          return error("لا يوجد عروض");
                        } else {
                          return _ListViewCategory();
                        }
                      }
                      break;
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المنتجات',
                    // style: Theme.of(context).textTheme.subhead,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProducts()));
                    },
                    child: Text(
                      'عرض الكل',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: ProductsApi().fetchProducts(1),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return _ListViewProducts();
                      break;
                    case ConnectionState.waiting:
                      // return loading();
                      break;

                    case ConnectionState.done:
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return error(snapshot.error.toString());
                      } else {
                        if (!snapshot.hasData) {
                          return error("لا يوجد منتجات");
                        } else {
                          return _ListViewProducts();
                        }
                      }
                      break;
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchesTextFormFild() {
    double height = MediaQuery.of(context).size.height;
    screenConfig = ScreenConfig(context);
    return Container(
      height: height / 3.5,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Card(
              margin: EdgeInsets.only(left: 0, right: 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              clipBehavior: Clip.hardEdge,
              child: Container(
                child: Image(
                  loadingBuilder:
                      (context, image, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return image;
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      'http://shop.myadeentrading.com/public/${names[index].image}'),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  Widget _ListViewCategory() {
    screenConfig = ScreenConfig(context);
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 7,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _gotoProduct(names[index], context);
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'http://shop.myadeentrading.com/public/${names[index].image}'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(new Radius.circular(100.00)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(
                    names[index].category_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    // style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 30,
        ),
      ),
    );
  }

  Widget _ListViewProducts() {
    //if (isLoading) return;

    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 4,
      child: ListView.separated(
        itemCount: product.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _gotoSingleProduct(product[index], context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(left: 0, right: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      height: height / 5.7,
                      width: 250,
                      child: Image(
                        loadingBuilder:
                            (context, image, ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return image;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            product[index].featuredImage()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(
                      product[index].product_title,
                      //style: Theme.of(context).textTheme.subhead,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Flexible(
                    child: Text(
                      '\R.Y  ${product[index].product_price}',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),

                  /* SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text('مكياج'),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    '\$755',
                    style: TextStyle(color: Colors.greenAccent),
                  ),
                ),*/
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 20,
        ),
      ),
    );
  }

  void _gotoProduct(ProductCategory category, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: ProductView(category)));
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }

  Widget _showLoading() {
    return SpinKitCubeGrid(
      size: 90,
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
