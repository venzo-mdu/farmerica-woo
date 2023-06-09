import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/models/global.dart' as Globals;
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';

import 'package:safira_woocommerce_app/ui/categories.dart';
import 'package:safira_woocommerce_app/ui/dashboard.dart';
import 'package:safira_woocommerce_app/ui/profile.dart';
import 'package:flutter/cupertino.dart';

class BasePage extends StatefulWidget {
  Customers customer;
  int selected;
  String title;
  BasePage({
    this.customer,
    this.title,
  });

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  List<Product> response;
  Api_Services api_services = Api_Services();

  List<ParentCategory> categories = [];
  List<Widget> list;
  int selected = 0;

  /// not working
  // List<Widget> _pages;
  // List<BottomNavigationBarItem> _items = [
  //   BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: "Home"),
  //   BottomNavigationBarItem(
  //       icon: Icon(Icons.category_rounded),
  //       label: "Category"),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.shopping_cart),
  //     label: "My Cart",
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.person),
  //     label: "My Account",
  //   )
  // ];
  // int _selectedPage;



  Future getList() async {
    categories = await api_services.getCategoryById(Globals.globalInt);
    response = await api_services.getProducts(Globals.globalInt);
  }

  @override
  void initState() {
    getList().then((value) {
      list = [
        Dashboard(
          product: response,
        ),
        CategoryPage(
          catergories: categories,
          product: response,
        ),
        CartScreen(
          product: response,
          details: widget.customer,
        ),
        CompleteProfileScreen(
          customer: widget.customer,
          product: response,
        )
      ];
    });

    // Bottom NavigationBar
    // _selectedPage = 0;
    // _pages = [
    //   Dashboard(
    //     product: response,
    //   ),
    //   CategoryPage(
    //     catergories: categories,
    //     product: response,
    //   ),
    //   CartScreen(
    //     product: response,
    //     details: widget.customer,
    //   ),
    //   CompleteProfileScreen(
    //     customer: widget.customer,
    //     product: response,
    //   )
    // ];
    super.initState();
  }

  Customers customer;

  @override
  Widget build(BuildContext context) {
    // String title = widget.title == null ? " " : widget.title;
    List<Widget> pages = [
      Dashboard(
        product: response,
        category: categories,
      ),
      CategoryPage(
        catergories: categories,
        product: response,
      ),
      CartScreen(
        product: response,
        details: widget.customer,
      ),
      CompleteProfileScreen(
        customer: widget.customer,
        product: response,
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00ab55),
        title: Image.network(
            'https://www.farmerica.in/wp-content/uploads/2023/01/farmerica-logo.png',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: (){
              print('Shopping Cart');
            },
            icon: Icon(Icons.shopping_bag_outlined)
          )
        ],
      ),
      body: body(context), //list.elementAt(selected),  //list[selected], //body(context),
      // body: pages[selected],
      ///
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: selected,
        iconSize: 30,
        selectedItemColor: Color(0xff00AA55),
        unselectedItemColor: Colors.black,

        onTap: (inx) {
          print('Index: $inx');
          setState(() {
            selected = inx;
          });
          print('SelectedIndex: $selected');
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category_rounded,
              ),
              label: "Category"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "My Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "My Account",
          )
        ],
        type: BottomNavigationBarType.shifting,
      ),
    );
  }


  Widget body(BuildContext context) {
    //String title = widget.title;

    List<Widget> list = [
      Dashboard(
        product: response,
        category: categories,
      ),
      CategoryPage(
        catergories: categories,
        product: response,
      ),
      CartScreen(
        product: response,
        details: widget.customer,
      ),
      CompleteProfileScreen(
        customer: widget.customer,
        product: response,
      )
    ];
    // print(categories);
    // print("aw+$response");
    return list[selected];
  }
}
