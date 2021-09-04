import 'package:flutter/material.dart';
import 'package:mart_n_cart/Common/Colors.dart';

import 'HomeScreen.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phonenumberController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _fullnameController.text = "Sunny";
      _emailController.text = "Sunny9876@gmail.com";
      _phonenumberController.text = "9879208321";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Update Profile"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextFormField(
                        controller: _fullnameController,
                        validator: (name) {
                          if (name.length == 0) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 15),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Enter Your Name',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 43,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 2, color: Colors.grey))),
                              child: Icon(
                                Icons.perm_identity,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (email) {
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = new RegExp(pattern);
                          print(email);
                          if (email.isEmpty) {
                            return 'Please enter email';
                          } else {
                            if (!regex.hasMatch(email))
                              return 'Enter valid Email Address';
                            else
                              return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 15),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Enter your Email',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 43,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 2, color: Colors.grey))),
                              child: Icon(
                                Icons.email,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextFormField(
                        readOnly: true,
                        controller: _phonenumberController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 15),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              width: 43,
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 2, color: Colors.grey))),
                              child: Icon(
                                Icons.call,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 13.0, right: 13, top: 50),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: RaisedButton(
                          color: appPrimaryMaterialColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new HomeScreen()));
                          },
                          child: isLoading == true
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "UPDATE",
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
            ],
          ),
        ),
      ),
    );
  }
}
