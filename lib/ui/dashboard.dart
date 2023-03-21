import 'package:flutter/material.dart';
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
    'https://www.farmerica.in/new/wp-content/uploads/2022/12/birthday-basket.jpg',
    'https://www.farmerica.in/new/wp-content/uploads/2022/12/anniversary-basket.jpg',
    'https://www.farmerica.in/new/wp-content/uploads/2023/01/vagitable-card.jpg',
    'https://www.farmerica.in/new/wp-content/uploads/2023/01/fruits-card-home.jpg',
    'https://www.farmerica.in/new/wp-content/uploads/2023/01/healthy-food-card-home.jpg'
  ];

  getList() {
    print('objectResponse: ${widget.product}');
    product = widget.product;
    // categories = widget.category;
    setState(() {});
  }

  // BasePage basePage = BasePage();
//
  // int selected = 2;
  String title = "Dashboard";
  //String title = "";

  @override
  void initState() {
    super.initState();
    getList();
    print(product);
    product = widget.product;
    print("ass+${widget.category}");

    // basePage.title = "My Cart";
    // basePage.selected = 0;
  }

  var padding = new Padding(
    padding: EdgeInsets.all(5.0),
  );

  @override
  Widget build(BuildContext context) {
    print("ass+${widget.category.length}");
    // print(categories);
    print(product);
    return WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Carousal(MediaQuery.of(context).size.width * 1.5),
            // Container(
            //   height: 40,
            //   child: UpperHeading("Get All Categories"),
            // ),
            // Container(
            //   child: CategoryPage(
            //     catergories: widget.category,
            //     product: widget.product,
            //   ),
            //   height: 100,
            // ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: 180,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffD7F5D8)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(Icons.calendar_today_outlined, color: Color(0xff214E23),),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Same Day', style: TextStyle(fontSize: 25, color: Color(0xff214E23), fontWeight: FontWeight.w600,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text('Delivery', style: TextStyle(fontSize: 18, color: Color(0xff214E23), fontWeight: FontWeight.w600,),),
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
                        color: Color(0xffF5D7D7)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.network(
                            'https://www.farmerica.in/new/wp-content/uploads/2023/01/Exciting-offers.png',
                            width: 25,
                            height: 25,
                            color: Color(0xff6A1414),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Exciting', style: TextStyle(fontSize: 25, color: Color(0xff6A1414), fontWeight: FontWeight.w600,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text('Discounts & Offers', style: TextStyle(fontSize: 18, color: Color(0xff6A1414), fontWeight: FontWeight.w600,),),
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
                        color: Color(0xffD7DFF5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.network(
                              'https://www.farmerica.in/new/wp-content/uploads/2023/01/free-delivery-icon.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Free', style: TextStyle(fontSize: 25, color: Color(0xff2E4990), fontWeight: FontWeight.w600,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text('Delivery', style: TextStyle(fontSize: 18, color: Color(0xff2E4990), fontWeight: FontWeight.w600,),),
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
                        color: Color(0xffEFF5D7)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: Icon(
                              Icons.workspace_premium_outlined,color: Color(0xff758D15), size: 35,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('100%', style: TextStyle(fontSize: 25, color: Color(0xff758D15), fontWeight: FontWeight.w600,),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          child: Text('Premium Products', style: TextStyle(fontSize: 18, color: Color(0xff758D15), fontWeight: FontWeight.w600,),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),




            Container(height: 33, child: UpperHeading("Recommended for you")),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 610,
              child: GridView.builder(
                itemCount: homeScreen.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        print('homeScreen: ${homeScreen[index]}');
                        print('widget.category: ${widget.category}');
                        print('widget.product: ${widget.product}');

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Grocery(
                                  // catergories: widget.category,
                                  product: widget.product,


                                )));
                      },
                      child: Image.network(homeScreen[index]));
                },
              ),
            ),
            // Container(
            //     height: 250,
            //     child: Recommendations(
            //       product: product,
            //     )),
            Container(height: 35, child: UpperHeading("Best Sellers Products")),
            Container(
                height: 250,
                child: ProductsHorizontal(
                  product: product,
                ))
          ],
        )));
  }
}
