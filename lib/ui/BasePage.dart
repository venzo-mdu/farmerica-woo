import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';

import 'package:safira_woocommerce_app/ui/categories.dart';
import 'package:safira_woocommerce_app/ui/dashboard.dart';
import 'package:safira_woocommerce_app/ui/profile.dart';

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
  List<int> category = [

  ];
  List<Widget> list;
  Future getList() async {
    categories = await api_services.getCategoryById(45);
    print('categoriesLength: ${categories.length}');

    response = await api_services.getProducts(45);
    print("categoriesResponse+${response.toString()}");
  }

  int selected = 0;
  @override
  void initState() {
    super.initState();
    // selected = widget.selected;
    getList().then((value) {
      print('list: $list');
      print('categories: $categories');
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
    print(categories);
    print("aw+$response");
    return list[selected];
  }

  Customers customer;

  @override
  Widget build(BuildContext context) {
    String title = widget.title == null ? " " : widget.title;
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
      ),
      CompleteProfileScreen(
        customer: customer,
        product: response,
      )
    ];
    print("ll+${response}");
    print("ll+${response.toString()}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Image.network(
            'https://www.farmerica.in/new/wp-content/uploads/2023/01/farmerica-logo.png',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: (){
              print('Shopping Cart');
            },
            icon: Icon(Icons.shopping_bag_outlined),
          )
        ],
      ),
      body: body(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: selected,
        iconSize: 30,
        selectedItemColor: Color(0xff00AA55),
        unselectedItemColor: Colors.black,
        onTap: (inx) {
          setState(() {
            selected = inx;
          });
          setState(() {});
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
              label: "My Account")
        ],
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
