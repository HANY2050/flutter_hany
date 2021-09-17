import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/products_api.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../animaterout.dart';

class ProductView extends StatefulWidget {
  //const ProductView({Key? key}) : super(key: key);
  final ProductCategory category;
  ProductView(this.category);
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with AutomaticKeepAliveClientMixin<ProductView> {
  var page = 1;

  ScreenConfig screenConfig;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Product> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  void initState() {
    super.initState();
    ProductsApi()
        .fetchProductsByCategory(widget.category.category_id, page)
        .then((dataFormServer) {
      setState(() {
        data = dataFormServer;
      });
    });
  }

  void _onRefresh() async {
    print(_onRefresh);
    await Future.delayed(Duration(seconds: 1));
    var List = await ProductsApi()
        .fetchProductsByCategory(widget.category.category_id, page);
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
    var List = await ProductsApi()
        .fetchProductsByCategory(widget.category.category_id, page);
    data.addAll(List);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double text = MediaQuery.textScaleFactorOf(context);
    final double itemHeight = (size.height - kToolbarHeight - 80) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.category.category_name),
      ),
      body: SmartRefresher(
        key: _refreshKey,
        controller: _refreshController,
        enablePullUp: true,
        child: GridView.count(
          key: _contentKey,
          crossAxisCount: 2,
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
                        height: height / 3.4,
                        width: width / 2.2,
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
                              data[index].featuredImage()),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        data[index].product_title,
                        //style: Theme.of(context).textTheme.subhead,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: text * 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Text(
                        '\R.Y  ${data[index].product_price}',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: text * 13,
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

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }

  @override
  bool get wantKeepAlive => true;
}
