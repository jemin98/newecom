import 'package:flutter/material.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Screens/CheckOutPage.dart';
import 'package:mart_n_cart/Screens/ProductListing.dart';
import 'package:mart_n_cart/Screens/SearchProductPage.dart';
import 'package:mart_n_cart/transitions/slide_route.dart';

class NoFoundComponent extends StatelessWidget {
  String ImagePath, Title, fromWhere;

  NoFoundComponent({this.ImagePath, this.Title, this.fromWhere});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("${ImagePath}", width: 80),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text("${Title}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54)),
          ),
          if (fromWhere == "Cart") ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, SlideLeftRoute(page: SearchProductPage()));
                  },
                  child: Text(
                    "Continue to Shopping",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: appPrimaryMaterialColor),
            )
          ]
        ],
      ),
    );
  }
}
