import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mart_n_cart/Common/services.dart';

class AddressProviderData extends ChangeNotifier {
  List addresslist = [];

  AddressProviderData() {
    getAdressData();
  }

  Future<int> getAdressData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.postforlist(apiname: 'getAddress').then((responselist) async {
          if (responselist.length > 0) {
            addresslist = responselist;
            notifyListeners();
          }
          return 0;
        }, onError: (e) {
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "something went wrong");
          return 0;
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return 0;
    }
  }
}
