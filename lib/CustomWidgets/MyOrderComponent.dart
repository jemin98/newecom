import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Screens/HomeScreen.dart';
import 'package:mart_n_cart/Screens/MyCartScreen.dart';
import 'package:mart_n_cart/Screens/OrderTab.dart';
import 'package:mart_n_cart/transitions/fade_route.dart';

class MyorderComponent extends StatefulWidget {
  var MyOrderData;

  MyorderComponent({this.MyOrderData});

  @override
  _MyorderComponentState createState() => _MyorderComponentState();
}

class _MyorderComponentState extends State<MyorderComponent> {
  String Pending = "completed";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            FadeRoute(
                page: OrderTab(
              OrderId: "24",
              pending: Pending, /*widget.MyOrderData["OrderId"]*/
            )));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(Icons.done, size: 20, color: appPrimaryMaterialColor),
              decoration: BoxDecoration(
                  border: Border.all(color: appPrimaryMaterialColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, bottom: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    "04/05/2021" /*"${widget.MyOrderData["OrderDeliveryDate"]}"*/,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: Text("Order ID ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700])),
                                        ),
                                        Text(
                                            "${024 + widget.MyOrderData}" /*"${widget.MyOrderData["OrderId"]}"*/,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700])),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Text("Rs",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[700])),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4.0,
                                              ),
                                              Text(
                                                  "200" /*"${widget.MyOrderData["OrderTotal"][0]["Total"]}"*/,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700])),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Text(
                                              Pending /*"${widget.MyOrderData["OrderStageDropDown"]}"*/),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child: Text("Items ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Colors.grey[700])),
                                              ),
                                              Text(
                                                  "2" /*"${widget.MyOrderData["OrderTotalQty"]}"*/,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700])),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: 25,
                                            child: FlatButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    FadeRoute(
                                                        page: MyCartScreen()));
                                              },
                                              color: appPrimaryMaterialColor,
                                              child: Text('Reorder',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15)),
                                            ),
                                          ),
                                        ),
                                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
