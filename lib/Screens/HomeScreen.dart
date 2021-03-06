import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Common/Constant.dart';
import 'package:mart_n_cart/Common/services.dart';
import 'package:mart_n_cart/CustomWidgets/CategoryComponent.dart';
import 'package:mart_n_cart/CustomWidgets/LoadingComponent.dart';
import 'package:mart_n_cart/CustomWidgets/OfferComponent.dart';
import 'package:mart_n_cart/CustomWidgets/ProductComponent.dart';
import 'package:mart_n_cart/CustomWidgets/TitlePattern.dart';
import 'package:mart_n_cart/Providers/CartProvider.dart';
import 'package:mart_n_cart/Screens/AddressScreen.dart';
import 'package:mart_n_cart/Screens/FilterScreen.dart';
import 'package:mart_n_cart/Screens/MyCartScreen.dart';
import 'package:mart_n_cart/Screens/OfferScreen.dart';
import 'package:mart_n_cart/Screens/ProfileScreen.dart';
import 'package:mart_n_cart/Screens/PromocodePage.dart';
import 'package:mart_n_cart/Screens/SearchProductPage.dart';
import 'package:mart_n_cart/Screens/SubCategoryScreen.dart';
import 'package:mart_n_cart/transitions/fade_route.dart';
import 'package:mart_n_cart/transitions/slide_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentBackPressTime;
  List _dashboardList = [];
  List _bannerList = [];
  List _categoryList = [];
  List _suggestedProductList = [];
  List _Offerlist = [];
  List<dynamic> Imageofsldier = ["assets/p2.jpg","assets/p1.jpg"];
  bool isLoading = false;
  bool iscartlist = false;
  Location location = new Location();
  LocationData locationData;
  String latitude, longitude;
  String CustomerName;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "press back again to exit");
      return Future.value(false);
    }
    return Future.value(true);
  }

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerName = preferences.getString(Session.CustomerName);
    });
  }

  @override
  void initState() {
    super.initState();
    _dashboardData();
    getlocaldata();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: isLoading == true ? Colors.white : Colors.grey[400],
        appBar: AppBar(
          centerTitle: false,
          title: GestureDetector(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: ProfileScreen()));
            },
            child: Row(
              children: [
                Container(
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 35,
                  ),
                ),
              /*  Icon(
                  Icons.account_box,
                  size: 27,
                ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello,",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Text(/*"${CustomerName}"*/ "Sunny",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appPrimaryMaterialColor,
          child: Icon(Icons.phone),
          onPressed: () {
            showDialog(
              context: context,
              // builder: (BuildContext context) => _buildPopupDialog(context),
              builder: (BuildContext context) => callback(),
            );
          },
        ),
        body: isLoading == true
            ? LoadingComponent()
            : _dashboardList.length > 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        _bannerList.length > 0
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: SizedBox(
                                  height: 180.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Carousel(
                                    boxFit: BoxFit.cover,
                                    autoplay: true,
                                    animationCurve: Curves.fastOutSlowIn,
                                    animationDuration:
                                        Duration(milliseconds: 1000),
                                    dotSize: 4.0,
                                    dotIncreasedColor: Colors.black54,
                                    dotBgColor: Colors.transparent,
                                    dotPosition: DotPosition.bottomCenter,
                                    dotVerticalPadding: 10.0,
                                    showIndicator: true,
                                    indicatorBgPadding: 7.0,
                                    images: Imageofsldier.map(
                                            (item) => Container(
                                          child: Center(
                                              child: Image.asset(
                                                item,
                                                fit: BoxFit.cover,

                                              )),
                                        )).toList(),

                                    /* _bannerList
                                        .map((item) => Container(
                                            child: Image.network(
<<<<<<< HEAD
                                              // "https://cdn.shopify.com/s/files/1/0397/8788/8795/t/8/assets/pf-de7d5e30--banner01-1.jpg",
                                                IMG_URL + item["BannerImage"],
=======
                                                "https://cdn.shopify.com/s/files/1/0397/8788/8795/t/8/assets/pf-de7d5e30--banner01-1.jpg",
                                                /*IMG_URL + item["BannerImage"],*/
>>>>>>> d02263328f050b0a142fffd096740a4d9b65f884
                                                fit: BoxFit.fill)))
                                        .toList(),*/
                                  ),
                                ),
                              )
                            : Container(),
                        /*Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 4.0),
                          child: Card(
                            child: Column(
                              children: [
                                TitlePattern(title: "Category"),
                                GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: _categoryList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return CategoryComponent(
                                        _categoryList[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),*/
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                                child:
                                    TitlePattern(title: "Products")),
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _suggestedProductList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductComponent(
                                    product: _suggestedProductList[index]);
                              }),
                        ),
                        

                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(color: Color(0xFF059983),
                                child:
                                TitlePattern(title: "New Arrivals")),
                          ),
                        ),
                        
                        SizedBox(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: /*_suggestedProductList.length,*/4,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ProductComponent(
                                    product: _suggestedProductList[index]);
                              }),
                        ),
                      ],
                    ),
                  )
                : Container(color: Colors.white),
        bottomNavigationBar: Container(
          height: 54,
          decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(top: BorderSide(color: Colors.grey, width: 0.3))),
          child: Row(
            children: <Widget>[
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/home.png',
                            width: 20, color: Colors.grey),
                        Text("Home", style: TextStyle(fontSize: 11))
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/loupe.png',
                            width: 20, color: Colors.grey),
                        Text("Search",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: Colors.black))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, FadeRoute(page: SearchProductPage()));
                  },
                ),
              ),
              Flexible(
                child: InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/discount.png',
                            width: 20, color: Colors.grey),
                        Text("Offers", style: TextStyle(fontSize: 11))
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, SlideLeftRoute(page: OfferScreen()));
                  },
                ),
              ),
              Flexible(
                child: Stack(
                  children: [
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/shoppingcart.png',
                                width: 22, color: Colors.grey),
                            Text("My Cart",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 11))
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, SlideLeftRoute(page: MyCartScreen()));
                      },
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      child: provider.cartCount > 0
                          ? CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              child: Text(
                                provider.cartCount.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0,
                                ),
                              ),
                            )
                          : Container(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dashboardData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.postforlist(apiname: 'getDashboardDataTest').then(
            (responselist) async {
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              _dashboardList = responselist;
              _bannerList = responselist[0]["Banner"];
              _categoryList = responselist[1]["Category"];
              _Offerlist = responselist[2]["Offer"];
              _suggestedProductList = responselist[3]["product"];
            });
            print(_bannerList);
          } else {
            setState(() {
              isLoading = false;
            });
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
}

class callback extends StatefulWidget {
  @override
  _callbackState createState() => _callbackState();
}

class _callbackState extends State<callback> {
  TextEditingController _numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
                color: appPrimaryMaterialColor,
              ),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Request Call",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                maxLines: 5,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                controller: _numController,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff6264a7)),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6264a7)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff6264a7)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: "Request Call",
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _numController.clear();
                    Navigator.pop(context);
                  },
                  child: Card(
                    color: Colors.grey,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Text(
                          "Close",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("yes");
                    if (_numController.text == "") {
                      Fluttertoast.showToast(msg: "Please Add Message");
                    }
                    else {
                      setState(() {});
                    }
                  },
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: Text(
                          "Request",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
