import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mart_n_cart/Common/services.dart';
import 'package:mart_n_cart/CustomWidgets/ProductComponent.dart';
class AllProducts extends StatefulWidget {

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  bool isLoading = false;

  List _suggestedProductList = [];
void  initState(){
  _dashboardData();
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
                  /*_dashboardList = responselist;
                  _bannerList = responselist[0]["Banner"];
                  _categoryList = responselist[1]["Category"];
                  _Offerlist = responselist[2]["Offer"];*/
                  _suggestedProductList = responselist[3]["product"];
                });
  /*              print(_bannerList);*/
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Products",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body:  SingleChildScrollView(
        child: Container(

          child: SizedBox(
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _suggestedProductList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ProductComponent(
                      product: _suggestedProductList[index]);
                }),
          ),

        ),
      ),
    );
  }
}
