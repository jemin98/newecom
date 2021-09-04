import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Common/Constant.dart';
import 'package:mart_n_cart/Common/services.dart';
import 'package:mart_n_cart/CustomWidgets/LoadingComponent.dart';
import 'package:mart_n_cart/CustomWidgets/MyCartComponent.dart';
import 'package:mart_n_cart/CustomWidgets/NoFoundComponent.dart';
import 'package:mart_n_cart/Providers/CartProvider.dart';
import 'package:mart_n_cart/Screens/AddressScreen.dart';
import 'package:mart_n_cart/Screens/CheckOutPage.dart';
import 'package:mart_n_cart/Screens/HomeScreen.dart';
import 'package:mart_n_cart/Screens/ProductDetailScreen.dart';
import 'package:mart_n_cart/transitions/fade_route.dart';
import 'package:mart_n_cart/transitions/slide_route.dart';

class MyCartScreen extends StatefulWidget {
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  bool isLoading = true;
  bool isBottomLoading = true;
  List cartList = [];
  List priceList = [];
  int Total = 0, Save = 0;
  String CustomerId,
      AddressId,
      AddressHouseNo,
      AddressName,
      AddressAppartmentName,
      AddressStreet,
      AddressLandmark,
      AddressArea,
      AddressType,
      AddressPincode;

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      CustomerId = preferences.getString(Session.customerId);
      AddressId = preferences.getString(AddressSession.AddressId);
      AddressHouseNo = preferences.getString(AddressSession.AddressHouseNo);
      AddressAppartmentName =
          preferences.getString(AddressSession.AddressAppartmentName);
      AddressStreet = preferences.getString(AddressSession.AddressStreet);
      AddressLandmark = preferences.getString(AddressSession.AddressLandmark);
      AddressArea = preferences.getString(AddressSession.AddressArea);
      AddressType = preferences.getString(AddressSession.AddressType);
      AddressPincode = preferences.getString(AddressSession.AddressPincode);
    });
  }

  @override
  void initState() {
    _getCartdata();
    getlocaldata();
  }

  _changeAddress(BuildContext context) async {
    List _addressData = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddressScreen(
                fromwehere: "MyCart",
              )),
    );
    print(_addressData);
    /*setState(() {
        CustomerId = _addressData[0];
        AddressId = _addressData[1];
        AddressHouseNo = _addressData[2];
        AddressAppartmentName = _addressData[3];
        AddressStreet = _addressData[4];
        AddressLandmark = _addressData[5];
        AddressArea = _addressData[6];
        AddressPincode =_addressData[7];
      });*/
  }

  _getCartdata() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        print(body.fields);
        Services.postforlist(apiname: 'getCarttest', body: body).then(
            (responselist) async {
          setState(() {
            isLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              isLoading = false;
              cartList = responselist[0]["Cart"];
              priceList = responselist[1]["carttotal"];
              print(body.fields);
            });
            getCartTotal();
          } else {
            Fluttertoast.showToast(msg: "No Product Found!");
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
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  getCartTotal() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        Services.postforlist(apiname: 'getCartTotal', body: body).then(
            (responselist) async {
          setState(() {
            isBottomLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              isBottomLoading = false;
              priceList = responselist;
              Total = priceList[0]["Total"];
              Save = priceList[0]["Save"];
            });
          } else {
            Fluttertoast.showToast(msg: "No Product Found!");
          }
        }, onError: (e) {
          setState(() {
            isBottomLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: isLoading == true
          ? LoadingComponent()
          : cartList.length > 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return MyCartComponent(
                              cartData: cartList[index],
                              onRemove: () {
                                setState(() {
                                  cartList.removeAt(index);
                                });
                              },
                              onQtyUpdate: () {
                                getCartTotal();
                              },
                            );
                          },
                          itemCount: cartList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                height: 7,
                                color: Colors.grey[300],
                              )),
                    ],
                  ),
                )
              : NoFoundComponent(
                  ImagePath: 'assets/noProduct.png',
                  Title: 'Your cart is empty',
                  fromWhere: "Cart"),
      bottomNavigationBar: isBottomLoading == true
          ? LoadingComponent()
          : Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ]),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 12.0),
                    child: priceList.length > 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rs: ${Total}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text("Saved  Rs. ${Save}"),
                            ],
                          )
                        : Container(),
                  ),
                  priceList[0]["Total"] != 0
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(color: Colors.red)),
                            onPressed: () {
                              Navigator.push(context,
                                  SlideLeftRoute(page: CheckoutPage()));
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text("Check out".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          ),
                        )
                      : Container(),
/*
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FlatButton(
                color: cartList.length == 0 ? Colors.black12 : Colors.red[400],
                textColor: cartList.length == 0 ? Colors.grey : Colors.white,
                splashColor: Colors.white24,
                onPressed: () {
                  if (cartList.length != 0) {
                    Navigator.push(
                        context, SlideLeftRoute(page: CheckoutPage()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Place Order",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
*/
                ],
              ),
            ),
    );
  }
}
