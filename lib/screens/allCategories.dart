import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/helpers_api.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/screens/productView.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../animaterout.dart';

class AllCategories extends StatefulWidget {
  //const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  var page = 1;

  ScreenConfig screenConfig;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<ProductCategory> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  void initState() {
    super.initState();
    HelpersApi().fetchCategories(page).then((dataFormServer) {
      setState(() {
        data = dataFormServer;
      });
    });
  }

  void _onRefresh() async {
    print(_onRefresh);
    await Future.delayed(Duration(seconds: 1));
    var List = await HelpersApi().fetchCategories(page);
    //Clear Old data
    //data.clear();
    // page;
    // Add New data
    data.addAll(List);
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    print(_onLoading);
    page++;
    var List = await HelpersApi().fetchCategories2(page);
    data.addAll(List);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    screenConfig = ScreenConfig(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double text = MediaQuery.textScaleFactorOf(context);
    final double itemHeight = (size.height - kToolbarHeight - 100) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('جميع الأقسام'),
      ),
      body: SmartRefresher(
        key: _refreshKey,
        controller: _refreshController,
        enablePullUp: true,
        child: GridView.count(
          key: _contentKey,
          crossAxisCount: 3,
          padding: EdgeInsets.only(top: 10),
          childAspectRatio: (itemWidth / itemHeight),
          children: List.generate(data.length, (index) {
            return InkWell(
              onTap: () {
                _gotoSingleProduct(data[index], context);
              },
              child: Container(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.only(left: 0, right: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        height: height / 6,
                        width: width / 3.5,
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
                          image: CachedNetworkImageProvider(
                              'http://shop.myadeentrading.com/public/${data[index].image}'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        data[index].category_name,
                        //style: Theme.of(context).textTheme.subhead,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: text * 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        physics: BouncingScrollPhysics(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
        ),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
      ),
    );
  }

  void _gotoSingleProduct(ProductCategory category, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: ProductView(category)));
  }
}
