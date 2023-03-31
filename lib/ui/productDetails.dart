import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart' as p;
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart';

class ProductDetail extends BasePage {
  ProductDetail({this.product});

  final p.Product product;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends BasePageState<ProductDetail> {
  int selected = 1;
  bool loa = true;
  String parsHtml(String as) {
    final htmls = parse(as);
    final String pars = parse(htmls.body.text).documentElement.text;
    // print(pars);
    setState(() {
      loa = false;
    });
    return pars;
  }

  String shortDes;
  final pincode = 751001;
  final List<int> pinCodes = [
    751001,
    752103,
    751022,
    751020,
    752103,
    751003,
    751009,
    752102,
    751014,
    751018,
    752100,
    752101,
    752102,
    752103,
    751002,
    751009,
    751003,
    752101,
    752100,
    752103,
    752103,
    751003,
    751002,
    751022,
    751014,
    751001,
    751009,
    751001,
    752102,
    752100,
    752102,
    751006,
    751011,
    752102,
    751016,
    752102,
    752103,
    752102,
    751019,
    751025,
    752100,
    752102,
    751003,
    751002,
    751002,
    751015,
    751002,
    752101,
    752101,
    752100,
    751024,
    752102,
    751024,
    751019,
    751006,
    751002,
    752103,
    751002,
    751030,
    751001,
    751002,
    752100,
    751006,
    751022,
    752102,
    752103,
    751003,
    751017,
    751017,
    751017,
    752101,
    751012,
    752102,
    751002,
    751001,
    751017,
    752103,
    751024,
    751019,
    751020,
    752102,
    752102,
    751008,
    751010,
    751013,
    751023,
    751007,
    751021,
    751005,
    751002,
    752100,
    751019,
    752102,
    752100,
    751007,
    752100,
    751006,
    751002,
    751003,
    752100,
    752102,
    751009,
    751004,
    751007,
    752054,
    752050,
    752054,
    752054,
    752050,
    752054,
    752054,
    752050,
    752050,
    752050,
    752050,
    752054,
    752054,
    752054,
    752054,
    752050,
    752050,
    752054,
    752050,
    752054,
    752050,
    752050,
    753015,
  ];
  var pincodeController = TextEditingController();
  bool flag = false;
  bool flags = true;
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
    // print(widget.product.shortDescription);
    shortDes = parsHtml(widget.product.shortDescription);
    // basePage.title = "Checkout Page";
    // basePage.selected = 2;
    // print("pincode:${pincodeController.text}");
  }

  @override
  Widget body(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = (screenSize.height) / 2;

    //var screenWidth = (screenSize.width) / 2;

    List<Product> cart = [];
    String title = widget.product.name;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //    // backgroundColor: product.color,
      //   backgroundColor: Colors.green,
      //   title: Text(
      //     widget.product.name,
      //     style: TextStyle(fontSize: 22),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(right: 10),
      //       child: Icon(
      //         Icons.add_shopping_cart,
      //         size: 30,
      //       ),
      //     )
      //   ],
      // ),
      body: ListView(
        children: [
          // container for the image of the product
          Container(
            height: screenHeight - 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    widget.product.images[0].src,

                    // width: width * 0.3,
                  )),
            ),
          ),
          // provides vertical space of 10 pxl
          SizedBox(height: 10),

          // container for the price & detail contents of the product
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                buildRowPriceRating(),
                SizedBox(height: 10),
                Text(widget.product.name, style: largeText),
                SizedBox(height: 10),
                Text(loa ? "" : shortDes, style: normalText),
                SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: pincodeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Postcode / ZIP",
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(0))),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(4.0),
                      // ),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xffFBB241)),
                      onPressed: () {
                        switch (pincodeController.text) {
                          case '751001':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751002':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751003':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751022':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751019':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751020':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751009':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '752101':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                          case '751022':
                            setState(() {
                              flag = true;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;


                          default:
                            setState(() {
                              flag = false;
                              flags = false;
                              // print('shippingVisibility: $shippingVisibility');
                            });
                            break;
                        }
                      },
                      // color: product.color,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "CHECK",
                          style: TextStyle(
                              fontSize: 15,

                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 10),

                flag
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Shipping methods available for your location:'),
                        Text('Free shipping'),
                        Text('Midnight Delivery 11pm to 12am: 200.00'),
                        Text('Early morning Delivery 6:30am to 7am : 75.00'),
                        ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff55C68A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onPressed: () {
                            Provider.of<CartModel>(context,
                                        listen: false)
                                        ;
                            cart.add(widget.product);
                            Provider.of<CartModel>(context, listen: false)
                                .addCartProduct(
                                widget.product.id,
                                1,
                                widget.product.name,
                                widget.product.price,
                                widget.product.images[0].src
                            );
                            Fluttertoast.showToast(
                                msg:
                                "${widget.product.name} successfully added to cart",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          // color: product.color,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Buy Now",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),

                      ],
                    )
                    : Center(child: flags
                      ? Text('Please enter a valid postcode / ZIP.', style: TextStyle(color: Colors.red))
                      : Text('Delivery not available', style: TextStyle(color: Colors.red))),

              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      //  backgroundColor: product.color,
      title: Text(
        widget.product.name,
        style: TextStyle(fontSize: 22),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.add_shopping_cart,
            size: 30,
          ),
        )
      ],
    );
  }

  Row buildRowPriceRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Price: ₹${widget.product.price}", style: largeText),
        // RatingBarIndicator(
        //   rating: 3.75,
        //   itemBuilder: (context, index) => Icon(
        //     Icons.star,
        //     color: Colors.amberAccent,
        //   ),
        //   itemCount: 5,
        //   itemSize: 25.0,
        //   direction: Axis.horizontal,
        // ),
      ],
    );
  }
}

TextStyle smallText = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
);

TextStyle normalText = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

TextStyle mediumText = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

TextStyle largeText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
