import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mart_n_cart/Common/Constant.dart';

class OrderDetailComponent extends StatefulWidget {
  var orderDetaildata;
  OrderDetailComponent({this.orderDetaildata});

  @override
  _OrderHistoryComponentState createState() => _OrderHistoryComponentState();
}

class _OrderHistoryComponentState extends State<OrderDetailComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 13.0),
                child: Center(
                  child: Container(
                    height: 120,
                    width: 110,
                    child: Image.asset("assets/mp_lokwan.png",fit: BoxFit.cover,),),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0, top: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(
                              "Order No : ",
                              // "${widget.ViewOrderdatacom["ProductName"]}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 13),
                            child: Text(
                              "${widget.orderDetaildata["OrderdetailId"]} ",
                              // "${widget.ViewOrderdatacom["ProductName"]}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, top: 5),
                        child: Text(
                          "${widget.orderDetaildata["ProductBrandName"]}",
                          // "${widget.ViewOrderdatacom["ProductName"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, top: 5),
                        child: Text("Product"
                          /*"${widget.orderDetaildata["ProductName"]}"*/,
                          // "${widget.ViewOrderdatacom["ProductName"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, left: 13),
                        child: Text(
                          "Rs : 350" /*+ "${widget.orderDetaildata["ProductSrp"]}"*/,
                          //  "${widget.ViewOrderdatacom["ProductDescription"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Quantity  :  ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            Text(
                              "${widget.orderDetaildata["OrderdetailQty"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
