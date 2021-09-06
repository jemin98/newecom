import 'package:flutter/material.dart';
import 'package:mart_n_cart/Common/Colors.dart';

class referEarn extends StatefulWidget {
  @override
  _referEarnState createState() => _referEarnState();
}

class _referEarnState extends State<referEarn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer & Earn"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset("assets/salary.png")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Your Refer Code: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Sun-Hgrb25",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, right: 13, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "The User will get Shopping 100 Point on each eligible account referred.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 13.0, right: 13, top: 50),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                  color: appPrimaryMaterialColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    //...........
                  },
                  child: isLoading == true
                      ? CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          "Share",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
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
