import 'package:flutter/material.dart';

Row buildBottomAppBar(BuildContext context) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0, // Move to right 10  horizontally
                15.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          color: Colors.white,
          /* border: Border.symmetric(
                  vertical: BorderSide(color: MyTheme.light_grey, width: .5),
                  horizontal: BorderSide(color: MyTheme.light_grey, width: 1))*/
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 52,
        width: MediaQuery.of(context).size.width * .33,
        child: new DropdownButton(
          icon: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(Icons.expand_more, color: Colors.black54),
          ),
          hint: Text(
            "Products",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          iconSize: 14,
          underline: SizedBox(),
          /*    value: _selectedFilter,
          items: _dropdownWhichFilterItems,
          onChanged: (WhichFilter selectedFilter) {
            setState(() {
              _selectedFilter = selectedFilter;
            });

       ),     _onWhichFilterChange();*/
        ),
      ),
      GestureDetector(
        onTap: () {
          /*   _selectedFilter.option_key == "product"
              ? _scaffoldKey.currentState.openEndDrawer()
              : ToastComponent.showDialog(
              "You can use filters while searching for products.",
              context,
              gravity: Toast.CENTER,
              duration: Toast.LENGTH_LONG);*/
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 25.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  50.0, // Move to right 10  horizontally
                  15.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            /*border: Border.symmetric(
                    vertical: BorderSide(color: MyTheme.light_grey, width: .5),
                    horizontal:
                        BorderSide(color: MyTheme.light_grey, width: 1))*/
          ),
          height: 52,
          width: MediaQuery.of(context).size.width * .33,
          child: Center(
              child: Container(
            width: 55,
            child: Row(
              children: [
                Icon(
                  Icons.filter_alt_outlined,
                  size: 13,
                ),
                SizedBox(width: 2),
                Text(
                  "Filter",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
      GestureDetector(
        /* onTap: () {
            _selectedFilter.option_key == "product"
                ? showDialog(
                    context: context,
                    builder: (_) =>
                        AlertDialog(
                          contentPadding: EdgeInsets.only(
                              top: 16.0, left: 2.0, right: 2.0, bottom: 2.0),
                          content: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Text(
                                      "Sort Products By",
                                    )),
                                RadioListTile(
                                  dense: true,
                                  value: "",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Default'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  value: "price_high_to_low",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Price high to low'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  value: "price_low_to_high",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Price low to high'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  value: "new_arrival",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('New Arrival'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  value: "popularity",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Popularity'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  value: "top_rated",
                                  groupValue: _selectedSort,
                                  activeColor: MyTheme.font_grey,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: const Text('Top Rated'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSort = value;
                                    });
                                    _onSortChange();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          }),
                          actions: [
                            FlatButton(
                              child: Text(
                                "CLOSE",
                                style: TextStyle(color: MyTheme.medium_grey),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ))*/
        onTap: () {
          /*  _selectedFilter.option_key == "product"
              ?*/
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile(
                      dense: true,
                      value: "",
                      /*groupValue: _selectedSort,
                      activeColor: MyTheme.font_grey,*/
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Default'),
                      onChanged: (value) {
                        /*  setState(() {
                          _selectedSort = value;
                        });
                        _onSortChange();*/
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      dense: true,
                      value: "price_high_to_low",
                      // groupValue: _selectedSort,
                      // activeColor: MyTheme.font_grey,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Price high to low'),
                      onChanged: (value) {
                        /* setState(() {
                          _selectedSort = value;
                        });
                        _onSortChange();*/
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      dense: true,
                      value: "price_low_to_high",
                      // groupValue: _selectedSort,
                      // activeColor: MyTheme.font_grey,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Price low to high'),
                      onChanged: (value) {
                        /*  setState(() {
                          _selectedSort = value;
                        });
                        _onSortChange();*/
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      dense: true,
                      value: "new_arrival",
                      // groupValue: _selectedSort,
                      // activeColor: MyTheme.font_grey,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('New Arrival'),
                      onChanged: (value) {
                        /*      setState(() {
                          _selectedSort = value;
                        });
                        _onSortChange();*/
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      dense: true,
                      value: "popularity",
                      // groupValue: _selectedSort,
                      // activeColor: MyTheme.font_grey,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Popularity'),
                      onChanged: (value) {
                        /*  setState(() {
                          _selectedSort = value;
                        });
                        _onSortChange();*/
                        Navigator.pop(context);
                      },
                    ),
                    RadioListTile(
                      dense: true,
                      value: "top_rated",
                      // groupValue: _selectedSort,
                      // activeColor: MyTheme.font_grey,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text('Top Rated'),
                      onChanged: (value) {
                        // setState(() {
                        //   _selectedSort = value;
                        // });
                        // _onSortChange();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 25.0, // soften the shadow
                spreadRadius: 5.0, //extend the shadow
                offset: Offset(
                  50.0, // Move to right 10  horizontally
                  15.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            /* border: Border.symmetric(
                    vertical: BorderSide(color: MyTheme.light_grey, width: .5),
                    horizontal:
                        BorderSide(color: MyTheme.light_grey, width: 1))*/
          ),
          height: 52,
          width: MediaQuery.of(context).size.width * .33,
          child: Center(
              child: Container(
            width: 50,
            child: Row(
              children: [
                Icon(
                  Icons.swap_vert,
                  size: 13,
                ),
                SizedBox(width: 2),
                Text(
                  "Sort",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          )),
        ),
      )
    ],
  );
}
