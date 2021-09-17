import 'package:flutter/material.dart';
import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../animaterout.dart';

class Ref extends StatefulWidget {
  // const Ref({Key? key}) : super(key: key);
  /*final ProductCategory category;
  Ref(this.category);*/
  @override
  _RefState createState() => _RefState();
}

class _RefState extends State<Ref> {
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
        title: 'Flutter Demo',
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
        home: ListViewPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class ListViewPage extends StatefulWidget {
  //const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  var page = 1;

  ScreenConfig screenConfig;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Product> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    ProductsApi().fetchProductsByCategory(9, page).then((dataFormServer) {
      setState(() {
        data = dataFormServer;
      });
    });
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

  Widget buildCtn() {
    return ListView.separated(
        key: _contentKey,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              SizedBox(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                          decoration: new BoxDecoration(color: Colors.white),
                          alignment: Alignment.center,
                          height: 150,
                          width: 150,
                          child: Image.network(data[index].featuredImage(),
                              fit: BoxFit.cover)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  data[index].product_title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '\R.Y  ${data[index].product_price}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 0.5,
            color: Colors.greenAccent,
          );
        },
        itemCount: data.length);
  }

  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: Text('pagination'),
        ),
        body: SmartRefresher(
          key: _refreshKey,
          controller: _refreshController,
          enablePullUp: true,
          child: buildCtn(),
          physics: BouncingScrollPhysics(),
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        ),
      ),
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      footerTriggerDistance: 30,
    );
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }
}
