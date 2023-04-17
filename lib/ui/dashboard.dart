import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/global.dart' as Globals;
import 'package:safira_woocommerce_app/models/Categories.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/Products.dart';
import 'package:safira_woocommerce_app/ui/Recommendedforyou.dart';
import 'package:safira_woocommerce_app/ui/categories.dart';
import 'package:safira_woocommerce_app/ui/categoriesDetails.dart';

import 'package:safira_woocommerce_app/ui/gertProductfromapi.dart';
import 'package:safira_woocommerce_app/ui/grocery.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';
import 'package:safira_woocommerce_app/ui/widgets/homeScreenBoxWidget.dart';

class Dashboard extends StatefulWidget {
  List<Product> product;
  List<ParentCategory> category;
  Dashboard({this.product, this.category});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Api_Services api_services = Api_Services();
  var response;
  int selected = 0;
  List<Product> product = [];

  List<String> homeScreen = [
    'https://www.farmerica.in/wp-content/uploads/2023/03/birthday-gift-basket.jpg',
    'https://www.farmerica.in/wp-content/uploads/2023/03/anniversary-gift-basket-1.jpg',
    'https://www.farmerica.in/wp-content/uploads/2023/03/exotic-vegetable-a-gift-basket.jpg',
    'https://www.farmerica.in/wp-content/uploads/2023/03/customize-fruits-basket.jpg',
    'https://www.farmerica.in/wp-content/uploads/2023/03/healthy-food-from-our-farm-1.jpg'
  ];

  getList() {
    // print('objectResponse: ${widget.product}');

    // categories = widget.category;
    setState(() {
      product = widget.product;
    });
  }

  // BasePage basePage = BasePage();
  // int selected = 2;
  String title = "Dashboard";
  //String title = "";

  @override
  void initState() {
    super.initState();
    // getList();
    // print(product);
    product = widget.product;
    // print("ass+${widget.category}");

    // basePage.title = "My Cart";
    // basePage.selected = 0;
  }

  var padding = Padding(
    padding: EdgeInsets.all(5.0),
  );

  @override
  Widget build(BuildContext context) {
    // print("ass+${widget.category.length}");
    // print(product);
    final orientation = MediaQuery.of(context).orientation;

    return WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Carousal(
              MediaQuery.of(context).size.width,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: 180,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffD7F5D8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff214E23),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Same Day',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff214E23),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff214E23),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: 190,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffF5D7D7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.network(
                            'https://www.farmerica.in/wp-content/uploads/2023/01/Exciting-offers.png',
                            width: 25,
                            height: 25,
                            color: Color(0xff6A1414),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Exciting',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff6A1414),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text(
                            'Discounts & Offers',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6A1414),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: 180,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffD7DFF5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.network(
                            'https://www.farmerica.in/wp-content/uploads/2023/01/free-delivery-icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff2E4990),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff2E4990),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    width: 190,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffEFF5D7)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Icon(
                            Icons.workspace_premium_outlined,
                            color: Color(0xff758D15),
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            '100%',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xff758D15),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text(
                            'Premium Products',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff758D15),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.25,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: homeScreen.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () async {
                        if (homeScreen[index].toString() ==
                            'https://www.farmerica.in/wp-content/uploads/2023/03/exotic-vegetable-a-gift-basket.jpg') {
                          Globals.globalInt = 68;
                          response = await api_services.getProducts(68);
                          print('vegetable: $response');
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => Grocery(
                                        product: response,
                                      )));
                        } else if (homeScreen[index].toString() ==
                            'https://www.farmerica.in/wp-content/uploads/2023/03/healthy-food-from-our-farm-1.jpg') {
                          Globals.globalInt = 86;
                          response = await api_services.getProducts(86);
                          print('healthy: $response');
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => Grocery(
                                        product: response,
                                      )));
                        } else {
                          Globals.globalInt = 45;
                          response = await api_services.getProducts(45);
                          print('category45: $response');
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => Grocery(
                                        // catergories: widget.category,
                                        product: response,
                                      )));
                        }
                      },
                      child: Image.network(homeScreen[index]));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Best Sellers Products\n\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Hand-crafted with care and attention to packaging detail makes our gift packs best seller and perfect for any occasion. Send them as a thanks or congratulations gift, our gifts are sure to please.',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 18))
                      ])),
            ),
            Center(
              heightFactor: 3.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff00ab55),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  response = await api_services.getProducts(86);
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (context) => Grocery(
                                product: response,
                              )));
                },
                child: Text('VIEW MORE'),
              ),
            )
          ],
        )));
  }
}
