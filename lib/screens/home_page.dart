import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generalshops/animaterout.dart';
import 'package:generalshops/api/cart_api.dart';
import 'package:generalshops/api/helpers_api.dart';
import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/product/home_products.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/screens/infoShops.dart';
import 'package:generalshops/screens/search.dart';
import 'package:generalshops/screens/showAllOrders.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:generalshops/screens/streams/dots_stream.dart';
import 'package:generalshops/screens/utilities/helperswidgets.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cart_screen.dart';

class Refresh extends StatefulWidget {
  // const Refresh({Key? key}) : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  _RefreshState();

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () =>
          WaterDropHeader(), // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
      footerBuilder: () =>
          ClassicFooter(), // Configure default bottom indicator
      headerTriggerDistance: 80.0, // header trigger refresh trigger distance
      //springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
      maxOverScrollExtent:
          100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
      maxUnderScrollExtent: 0, // Maximum dragging range at the bottom
      enableScrollWhenRefreshCompleted:
          true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
      enableLoadingWhenFailed:
          true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
      hideFooterWhenNotFull:
          false, // Disable pull-up to load more functionality when Viewport is less than one screen
      enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar', 'AE'), // English, no country code
          const Locale('es', ''), // Spanish, no country code
        ],
        title: 'Flutter Demo',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          buttonTheme: ButtonThemeData(),
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: ScreenUtilities.textColor,
            ),
            subhead: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ScreenUtilities.textColor,
            ),
            display1: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: ScreenUtilities.darkerGreyText,
            ),
            display2: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 18,
              height: 1.75,
              letterSpacing: 1,
              color: ScreenUtilities.darkerGreyText,
            ),
          ),
          appBarTheme: AppBarTheme(
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: ScreenUtilities.textColor,
            ),
            textTheme: TextTheme(
              // ignore: deprecated_member_use
              title: TextStyle(
                color: ScreenUtilities.textColor,
                fontFamily: " Quicksand",
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: ScreenUtilities.textColor,
            labelStyle: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
            labelPadding:
                EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 14),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: ScreenUtilities.unselected,
            unselectedLabelStyle: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              fontFamily: "Quicksand",
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: ScreenUtilities.mainBlue,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  Product product;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;
  CartApi cartApi = CartApi();
  List<ProductCategory> productsCategories;
  PageController _pageController;
  HelpersApi helpersApi = HelpersApi();
  DotsStream dotsStream = DotsStream();
  bool _addingToFavorite = false;

  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  HomeProductBloc homeProductBloc = HomeProductBloc();
  var page = 1;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Product> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();
  /*_HomePageState(this.user);*/

  @override
  void initState() {
    super.initState();
    homeProductBloc.productsApi.fetchProductsByCategory(9, page);
    /* ProductsApi().fetchProductsByCategory(9, page).then((dataFormServer) {
      setState(() {
        data = dataFormServer;
      });
    });*/
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.75,
    );
  }

  void _onRefresh() async {
    print(_onRefresh);
    await Future.delayed(Duration(seconds: 1));
    var List = await ProductsApi().fetchProductsByCategory(9, page);
    //Clear Old data
    data.clear();
    page = 1;
    // Add New data
    data.addAll(List);
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    print(_onLoading);
    page++;
    var List = await ProductsApi().fetchProductsByCategory(9, page);
    data.addAll(List);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);

    return FutureBuilder(
      future: helpersApi.fetchCategories(1),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductCategory>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return error("No connection made");
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
                return error("No Data Found");
              } else {
                this.productsCategories = snapshot.data;
                homeProductBloc.fetchProducts
                    .add(this.productsCategories[0].category_id);
                return _screen(snapshot.data, context);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
    tabController = TabController(
      initialIndex: 0,
      length: categories.length,
      vsync: this,
    );
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
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          // ignore: deprecated_member_use
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
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
        bottom: TabBar(
          indicatorColor: ScreenUtilities.mainBlue,
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ), //For Selected tab
          unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),

          indicatorWeight: 2,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
          onTap: (int index) {
            homeProductBloc.fetchProducts
                .add(this.productsCategories[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: homeProductBloc.productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return error('No Think Is Working!');
                break;
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return error(snapshot.error.toString());
                } else {
                  if (!snapshot.hasData) {
                    return error('No Data');
                  } else {
                    return _drawProducts(snapshot.data, context);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 3;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);

    for (int index in indexes) {
      newProducts.add(products[index]);
    }

    return newProducts;
  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: topProducts.length,
                onPageChanged: (int index) {
                  dotsIndex.value = index;
                },
                itemBuilder: (context, position) {
                  return InkWell(
                    onTap: () {
                      _gotoSingleProduct(topProducts[position], context);
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        child: Image(
                          loadingBuilder: (context, image,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return image;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              topProducts[position].featuredImage()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: dotsIndex,
              builder: (context, value, _) {
                return Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _drawDots(topProducts.length, value),
                  ),
                );
              },
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, position) {
                      return InkWell(
/*
                      onTap: () {
                   Navigator.pop(context);
                   Navigator.push(context,
                   MaterialPageRoute(builder: (context) => _gotoSingleProduct(products[position], context)));*/

                        onTap: () {
                          _gotoSingleProduct(products[position], context);
                        },
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              child: Container(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white),
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        child: Image.network(
                                            products[position].featuredImage(),
                                            fit: BoxFit.cover)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                products[position].product_title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '\R.Y  ${products[position].product_price}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _drawDots(int qty, int index) {
    List<Widget> Wigdets = [];
    for (int i = 0; i < qty; i++) {
      Wigdets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == index)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.LightGrey,
          ),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 10)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return Wigdets;
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];

    for (ProductCategory category in categories) {
      tabs.add(
        Tab(
          text: category.category_name,
        ),
      );
    }
    return tabs;
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }
}
