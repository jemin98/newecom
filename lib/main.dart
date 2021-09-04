import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Screens/HomeScreen.dart';
import 'package:mart_n_cart/Screens/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:mart_n_cart/Common/Colors.dart';
import 'package:mart_n_cart/Common/Constant.dart';
import 'package:mart_n_cart/Providers/Addressprovider.dart';
import 'package:mart_n_cart/Providers/SettingProvider.dart';
import 'package:mart_n_cart/Screens/SplashScreen.dart';

import 'Providers/CartProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mart N Cart',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Lato',
          cursorColor: Colors.black54,
          primaryColor: appPrimaryMaterialColor,
          appBarTheme: AppBarTheme(
              centerTitle: true,
              textTheme: TextTheme(
                  // ignore: deprecated_member_use
                  title: TextStyle(color: Colors.white, fontSize: 16)),
              iconTheme: IconThemeData(color: Colors.white)),
          accentColor: appPrimaryMaterialColor),
    );
  }
}
