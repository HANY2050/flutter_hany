import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/screen_user.dart';
import 'package:generalshops/screens/homePage4.dart';
import 'package:generalshops/screens/showAllOrders.dart';
import 'package:generalshops/screens/utilities/size_config.dart';

import 'allProduct.dart';

class ControllerView extends StatefulWidget {
  // const ControllerView({Key? key}) : super(key: key);

  @override
  _ControllerViewState createState() => _ControllerViewState();
}

class _ControllerViewState extends State<ControllerView> {
  var _currentTab;
  List<Widget> screens;
  /*final List<Widget> screens = [
    HomeView(),
    CartScreen(),
    OrdersAll(),
    OrdersAll(),
    AllProducts(),
  ];*/
  PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _currentTab = 0;
    screens = [
      HomeView(),

      /* CartScreen(),
     .-0 OrdersAll(),
      OrdersAll(),*/
      AllProducts(),
      ProfilePages(),
      OrdersAll(),
    ];
    _pageController = PageController(initialPage: _currentTab);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeView();

  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  @override
  Widget build(BuildContext context) {
    double text = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: screens,
        //onPageChanged:currentScreen ,
        //child: currentScreen
        /*child: currentScreen,
        bucket: bucket,*/
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_outlined),
            label: 'المنتجات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'طلباتي',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentTab,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (currentTab) {
          setState(() {
            _currentTab = currentTab;
            _pageController.jumpToPage(currentTab);
          });
        },
      ),
      /*  bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: 60,
          //  width: width / 4,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20, top: 7),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = CartScreen();
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                            size: 25,
                          ),
                          Text(
                            'ألسلة',
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey,
                              fontSize: text * 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = OrdersAll();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.table_chart,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                            size: 25,
                          ),
                          Text(
                            'طلباتي',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                              fontSize: text * 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = HomeView();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                            size: 25,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey,
                              fontSize: text * 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = AllProducts();
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.payment_outlined,
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                            size: 25,
                          ),
                          Text(
                            'المنتجات',
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey,
                              fontSize: text * 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 10,
                      onPressed: () {
                        setState(() {
                          currentScreen = ProfilePages();
                          currentTab = 4;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.person,
                            color: currentTab == 4 ? Colors.blue : Colors.grey,
                            size: 25,
                          ),
                          Text(
                            'حسابي',
                            style: TextStyle(
                              color:
                                  currentTab == 4 ? Colors.blue : Colors.grey,
                              fontSize: text * 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
    /* });*/
  }

  /* Widget bottomNavigationBar() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('ألرئيسية'),
            ),
            label: '',
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/ex.jpg",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon:
                Padding(padding: EdgeInsets.only(top: 10), child: Text('Cart')),
            label: '',
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/cart.png",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Acount'),
            ),
            label: '',
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/acount.png",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
          ),
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index) {
          print(index);
          controller.changeSelectedValue(index);
          if (index == 0) {
            currentScreen = HomeView();
          }
          if (index == 1) {
            currentScreen = CartView();
          }
          if (index == 2) {
            currentScreen = CartView();
          }
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }*/
}
