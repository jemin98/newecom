import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mart_n_cart/Common/Constant.dart';
import 'package:mart_n_cart/Common/services.dart';
import 'package:mart_n_cart/CustomWidgets/LoadingComponent.dart';
import 'package:mart_n_cart/CustomWidgets/NoFoundComponent.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderHistoryScreen extends StatefulWidget {
  String pending;

  OrderHistoryScreen({this.pending});
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List OrderHistoryList = [];
  String CustomerId;
  bool isorderDetailLoading = false;
  bool isLoading = false;
  TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    _getorderHistory();
    getlocaldata();
  }

  getlocaldata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CustomerId = await preferences.getString(Session.customerId);
  }

  _getorderHistory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isorderDetailLoading = true;
        });
        FormData body = FormData.fromMap({"CustomerId": CustomerId});
        print(body.fields);
        Services.postforlist(apiname: 'orderHistoryTest', body: body).then(
            (responselist) async {
          setState(() {
            isorderDetailLoading = false;
          });
          if (responselist.length > 0) {
            setState(() {
              OrderHistoryList = responselist;
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found!");
          }
        }, onError: (e) {
          setState(() {
            isorderDetailLoading = false;
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
        backgroundColor: Colors.grey[300],
        // appBar: AppBar(
        //   elevation: 1,
        //   title: Text("Order History",
        //       style: TextStyle(color: Colors.white, fontSize: 18)),
        // ),
        body: isorderDetailLoading
            ? LoadingComponent()
            : /* OrderHistoryList.length > 0
                ? */
            ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0, top: 30),
                    child: Text("Address",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 8, left: 8),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                        "Sunny" /*"${OrderHistoryList[0]["CustomerName"]}"*/,
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 9.0),
                                    child: Text(
                                        "C-210" /*"${OrderHistoryList[0]["AddressHouseNo"]}"*/ +
                                            " , " +
                                            "Silver Hub" /*"${OrderHistoryList[0]["AddressAppartmentName"]}"*/,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                        "adajan chowk" /*"${OrderHistoryList[0]["AddressStreet"]}"*/ +
                                            " , " /*+
                                            "${OrderHistoryList[0]["AddressLandmark"]}"*/
                                            +
                                            " , " +
                                            "Mumbai - 395010" /*"${OrderHistoryList[0]["AddressArea"]}"*/,
                                        //"${widget.addressData["AddressStreet"]}",

                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                  ),
                                  /* Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                        "${OrderHistoryList[0]["AddressCityName"]}" +
                                            " , " +
                                            "${OrderHistoryList[0]["AddressPincode"]}"

                                        // "${widget.addressData["AddressLandmark"]}",
                                        ,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[700])),
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Colors.grey[700],
                                          size: 19,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Text(
                                              "5487968525" /* "${OrderHistoryList[0]["CustomerPhoneNo"]}"*/,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey[700])),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                    child: Text("Payment Detail",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 8, left: 8),
                    // child: GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         FadeRoute(
                    //             page: OrderTab(
                    //           OrderId: OrderHistoryList[0]["OrderId"],
                    //         )));
                    //   },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 10, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text("Order No",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                )),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 8.0),
                                          //   child: Text(":",
                                          //       style: TextStyle(
                                          //         color: Colors.grey[700],
                                          //         fontSize: 14,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                            "24" /*"${OrderHistoryList[0]["OrderId"]}"*/,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            )),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7.0),
                                            child: Text("Delivery Options",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                )),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 3.0),
                                          //   child: Text(":",
                                          //       style: TextStyle(
                                          //         color: Colors.grey[700],
                                          //         fontSize: 14,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                            "Express" /*"${OrderHistoryList[0]["OrderPaymentMethod"]}"*/,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            )),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7.0),
                                            child: Text("Sub total",
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontSize: 14,
                                                )),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 3.0),
                                          //   child: Text(":",
                                          //       style: TextStyle(
                                          //         color: Colors.grey[700],
                                          //         fontSize: 14,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                            "200" /*"${OrderHistoryList[0]["OrderPayment"][0]["SubTotal"]}"*/,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            )),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7.0),
                                            child: Text("Delivery charges",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 14)),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 8.0),
                                          //   child: Text(":",
                                          //       style: TextStyle(
                                          //         color: Colors.grey[700],
                                          //         fontSize: 14,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                            "0" /*"${OrderHistoryList[0]["OrderPayment"][0]["Deliver Charges"]}"*/,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            )),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7.0),
                                            child: Text("Total",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(top: 3.0),
                                          //   child: Text(":",
                                          //       style: TextStyle(
                                          //         color: Colors.grey[700],
                                          //         fontSize: 14,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 7.0),
                                        child: Text(
                                            "200" /*"${OrderHistoryList[0]["OrderTotal"][0]["Total"]}"*/,
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                    child: Text("Tracking",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 8, left: 8),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 30, bottom: 30),
                          child: Center(
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Order Accepted"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("PickedUp"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("Ready To Deliver"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("Deliverd"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Container(
                                    width: 4,
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    color: appPrimaryMaterialColor,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("04/09/2021 12:30"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("04/09/2021 1:30"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("04/09/2021 4:30"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("04/09/2021 5:30"),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                    child: Text("Feedback",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 8, left: 8),
                    // child: GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         FadeRoute(
                    //             page: OrderTab(
                    //           OrderId: OrderHistoryList[0]["OrderId"],
                    //         )));
                    //   },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 10, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 2.0,
                                    updateOnDrag: true,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 25,
                                    glow: false,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 3.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      var rat = rating;
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: TextFormField(
                                      maxLines: 3,
                                      controller: _feedbackController,
                                      validator: (name) {
                                        /*  if (name.length == 0) {
                                          return 'Please enter your name';
                                        }*/
                                        return null;
                                      },
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(fontSize: 15),
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        hintText: 'Start typing Here',
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 13.0, right: 13, top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: RaisedButton(
                        color: appPrimaryMaterialColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          /* Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new LoginScreen()));
                          if (isLoading == false) _registration();*/
                        },
                        child: isLoading == true
                            ? CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              )
                            : Text(
                                "SEND",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  )
                ],
              )
        /*: NoFoundComponent()*/);
  }
}
