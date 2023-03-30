import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Products.dart' as p;
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/createOrder.dart';
import "package:provider/provider.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:safira_woocommerce_app/models/global.dart' as Globals;


class AddtoCart {
  int addtoCart;
  AddtoCart({this.addtoCart});
}

class CartScreen extends BasePage {
  static String routeName = "/cart";
  List<p.Product> product;
  Customers details;

  CartScreen({this.product, this.details});
  @override
  _CartScreenState createState() => _CartScreenState();
}

enum shipping {
  Free_Shipping,
  Midnight_Delivery_11pm_to_12am,
  Early_morning_Delivery_6am_to_7am
}

var totalprice = 0;

// int arraySize = 1;
// List<int> counterArray = new List.filled(arraySize, null, growable: false);

class _CartScreenState extends BasePageState<CartScreen> {
  int counter = 1;
  int arraySize = 1;
  List counterArray = [
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
  ];

  double subTotals = 0.0;

  List<AddtoCart> addtoCart = [];
  List<Product> product;
  Product cart;
  int quantity = 1;
  int selected = 2;
  String title = "My Cart";
  var totalIndexPrice;
  double totalIndexPrices = 0.0;
  // var totalSubtotal = 0.0;
  double totalSubtotal = 0.0;
  int dummyCount = 0;
  double finalTotal = 0.0;

  Timer timer;
  var shippingFee = 0;

  bool intFlag = false;
  TextEditingController _couponCodeController = TextEditingController();

  @override
  void initState() {
    print('CartLength85: ${widget.product.length}');
    super.initState();
  }

  void increment(int index) {
    setState(() {
      counter++;
      counterArray[index]++;
    });
  }

  calc() async {
    // totalIndexPrices += double.parse(cart[index].price);
    // totalSubtotal += double.parse(totalIndexPrice.toString());
  }

  void decrement(int index) {
    setState(() {
      counter--;
      counterArray[index]--;
    });
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apply the Coupon'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: _couponCodeController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Coupon Code',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  shipping _character = shipping.Free_Shipping;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    getList() async {
      categories = await api_services.getCategoryById(Globals.globalInt);
      response = await api_services.getProducts(Globals.globalInt);
    }

    List<p.Product> demoCarts = widget.product;
    List<p.Product> cart = [];

    // print('demoCarts: ${demoCarts.toList().toString()}');

    return Consumer<CartModel>(builder: (context, cartModel, child) {
      print('CartModel157: ${cartModel.cartProducts.length}');
      if (cartModel.cartProducts.length == 0) {
        return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.hourglass_empty,
            size: 30,
          ),
          Text(
            "Your Cart is empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]));
      } else {
        // if(intFlag == false ) {
        totalSubtotal = 0;
        print('demoCarts.length: ${demoCarts.length}');
        for (var item in demoCarts) {
          for (var it in cartModel.cartProducts) {
            if (it.product_id == item.id) {
              cart.add(item);
              addtoCart.add(AddtoCart(addtoCart: 1));
              if (intFlag == false) {
                subTotals += double.parse(item.price);
                finalTotal += double.parse(item.price);
              }
              arraySize++;
              // }
              // }
              // List<int> counterArray = new List.filled(arraySize, null, growable: false);
              // for(int i=0; i<arraySize; i++) {
              //   counterArray[i]=1;
              // }
              // cart.forEach((element) {
              //   print('element165: ${element.price}');
              //
              //   for (var item in demoCarts) {
              //     print('insideElement: ${element.id}');
              //     print('insideItem: ${item.id}');
              //     if(item.id == element.id) {
              //       totalSubtotal += double.parse(element.price);
              //       finalTotal += double.parse(element.price);
              //     }
              //   }
              //
              //     print('dummyCount :${element.price.length}');
              //   print('element165runtime: ${element.price.runtimeType}');
              //   // totalSubtotal += double.parse(element.price);
              //   // finalTotal += double.parse(element.price);
              //   // totalSubtotal += totalIndexPrice;
              //
              //
              //
              //   print('totalIndexPrice167: ${totalIndexPrice.runtimeType}');
              //   print('totalIndexPrice167: ${totalIndexPrice}');
              // });

            }
            intFlag = true;
          }
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: cart.length, //
                    itemBuilder: (context, index) {
                      // int pr = cart[index].price as int;
                      // totalIndexPrice = cart[index].price;
                      // print('objectTotal: ${totalIndexPrice}');
                      // total = double.parse(cart[index].price);
                      // totalIndexPrices += double.parse(cart[index].price);
                      // print('totalIndexPrice: $totalIndexPrices');
                      // print('totalIndexPrice: ${cart[index].price}');
                      // print('totalIndexPrice: ${[index]}');
                      // totalSubtotal += double.parse(totalIndexPrice.toString());
                      // print('total Sub total: ${totalSubtotal}');
                      //
                      // print('final: ${totalSubtotal.toString()}');

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                            child: Dismissible(
                              key: Key(cart[index].id.toString()),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  cart.removeAt(index);
                                  cartModel.removeCartProduct(cart[index].id);
                                });
                              },
                              background: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  // color: Color(0xFFFFE6E6),
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    SvgPicture.asset(
                                      "assets/Trash.svg",
                                    ),
                                  ],
                                ),
                              ),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 84,
                                          child: AspectRatio(
                                            aspectRatio: 0.88,
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF5F6F9),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.network(
                                                  cart[index].images[0].src),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                          height: 100,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cart[index].name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: width * 0.04),
                                              maxLines: 2,
                                            ),
                                            SizedBox(height: 10),
                                            Text.rich(
                                              TextSpan(
                                                text: "\₹${cart[index].price}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFFF7643)),
                                                children: [
                                                  TextSpan(
                                                      text: " ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                TextButton(
                                                    onPressed: () {
                                                      decrement(index);
                                                      // var amount= 0;
                                                      // for(int i=0; i<cart.length;i++) {
                                                      //   amount += int.parse(cart[i].price) * counterArray[i];
                                                      // }
                                                      // // var amount = double.parse(
                                                      // //     totalIndexPrice) *
                                                      // //     counter;
                                                      // // print('amt:${amount}');
                                                      //
                                                      // totalSubtotal = amount as double;
                                                      // print('totalSubtotal335: ${totalSubtotal}');

                                                      var amount = 0;
                                                      subTotals = 0;
                                                      for (int i = 0;
                                                          i < cart.length;
                                                          i++) {
                                                        // print(
                                                        //     'counterArray342: ${counterArray[i]}');
                                                        // print(
                                                        //     'counterArray343: ${cart[i].price}');

                                                        subTotals += int.parse(
                                                                cart[i].price) *
                                                            counterArray[i];
                                                      }
                                                      finalTotal = shippingFee +
                                                          subTotals;
                                                    },
                                                    child: Text('-')),
                                                Text(
                                                    '${counterArray[index].toString()}'),
                                                TextButton(
                                                    onPressed: () {
                                                      increment(index);
                                                      var amount = 0;
                                                      subTotals = 0;
                                                      for (int i = 0;
                                                          i < cart.length;
                                                          i++) {
                                                        // print(
                                                        //     'counterArray342: ${counterArray[i]}');
                                                        // print(
                                                        //     'counterArray343: ${cart[i].price}');

                                                        subTotals += int.parse(
                                                                cart[i].price) *
                                                            counterArray[i];
                                                      }
                                                      finalTotal = shippingFee +
                                                          subTotals;

                                                      // var amount = double.parse(
                                                      //     totalIndexPrice) *
                                                      //     counter;
                                                      // var shippingtotal=amount
                                                      // print(
                                                      //     'totalSubtotal353amt:$amount');
                                                      // // totalSubtotal = amount as double;
                                                      // print(
                                                      //     'totalSubtotal355: $subTotals');
                                                      // print(
                                                      //     'totalIndex354:${double.parse(totalIndexPrice)}');
                                                      // print('amt:${double.parse(cart[index].price)}');
                                                      // print('amt:${counter.runtimeType}');
                                                    },
                                                    child: Text('+')),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                product: cart[index],
                                              )));
                                },
                              ),
                            ),
                            onTap: () {}),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  // height: 174,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -15),
                        blurRadius: 20,
                        color: Color(0xFFDADADA).withOpacity(0.15),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    'CART TOTALS',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Subtotal'),
                                ),
                                Text('₹$subTotals'),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Shipping'),
                                Text(shipping.Free_Shipping == _character
                                    ? '₹0.00'
                                    : shipping.Early_morning_Delivery_6am_to_7am ==
                                            _character
                                        ? '₹75.00'
                                        : '₹200.00'),
                              ],
                            ),
                            Row(
                              children: [
                                // Text('Free shipping'),
                                Text('$_character'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Shipping to 751001, India'),
                              ],
                            ),
                            Column(
                              children: [
                                RadioListTile<shipping>(
                                    title: Text("Free shipping"),
                                    subtitle: Text('₹0.00'),
                                    value: shipping.Free_Shipping,
                                    groupValue: _character,
                                    onChanged: (shipping value) {
                                      setState(() {
                                        finalTotal = 0;
                                        for (int i = 0; i < cart.length; i++) {
                                          finalTotal +=
                                              int.parse(cart[i].price) *
                                                  counterArray[i];
                                        }
                                        finalTotal = 0 + finalTotal;

                                        shippingFee = 0;
                                        _character = value;
                                      });
                                    }),
                                RadioListTile<shipping>(
                                    title:
                                        Text("Midnight Delivery 11pm to 12am"),
                                    subtitle: Text('₹200.00'),
                                    value:
                                        shipping.Midnight_Delivery_11pm_to_12am,
                                    groupValue: _character,
                                    onChanged: (shipping value) {
                                      setState(() {
                                        finalTotal = 0;
                                        for (int i = 0; i < cart.length; i++) {
                                          finalTotal +=
                                              int.parse(cart[i].price) *
                                                  counterArray[i];
                                        }
                                        finalTotal = 200 + finalTotal;

                                        _character = value;
                                        shippingFee = 200;
                                        double a = 200;
                                        // finalTotal = subTotals + a.toDouble();
                                        // print(
                                        //     'total Sub total: ${totalSubtotal.toDouble()}');
                                        // print(
                                        //     'finalTotal: ${finalTotal.toDouble()}');
                                      });
                                    }),
                                RadioListTile<shipping>(
                                    title: Text(
                                        "Early morning Delivery 6.30am to 7am"),
                                    subtitle: Text('₹75.00'),
                                    value: shipping
                                        .Early_morning_Delivery_6am_to_7am,
                                    groupValue: _character,
                                    onChanged: (shipping value) {
                                      setState(() {
                                        finalTotal = 0;
                                        for (int i = 0; i < cart.length; i++) {
                                          finalTotal +=
                                              int.parse(cart[i].price) *
                                                  counterArray[i];
                                        }
                                        finalTotal = 75 + finalTotal;

                                        shippingFee = 75;
                                        _character = value;
                                        double a = 75.0;

                                        // finalTotal = subTotals + a.toDouble();
                                        // print(
                                        //     'totalSubtotalruntimeType: ${totalSubtotal.runtimeType}');
                                        // print(
                                        //     'finalTotal: ${finalTotal.toDouble()}');
                                      });
                                    }),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('Total: '),
                                ),
                                Text('₹${finalTotal.toString()}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SvgPicture.asset("assets/receipt.svg"),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                _showAlertDialog();
                              },
                              child: Text("Add voucher code")),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            // color: ,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ))),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text("Check Out",
                                    style: TextStyle(fontSize: 18)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateOrder(
                                              shippingFee: shippingFee,
                                              id: widget.details.id,
                                              cartProducts:
                                                  cartModel.cartProducts,
                                              product: cart,
                                            )));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }
}

class Body extends StatefulWidget {
  final List<p.Product> demoCarts;
  Customers details;
  Body({this.demoCarts});
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<p.Product> demoCarts = [p.Product()];
  int addTocart = 0;
  @override
  Widget build(BuildContext context) {
    demoCarts = widget.demoCarts;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: 0 == 1
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Icon(
                      Icons.hourglass_empty,
                      size: 30,
                    ),
                    Text(
                      "Your Cart is empty",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]))
            : ListView.builder(
                itemCount: demoCarts.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                      child: Dismissible(
                        key: Key(demoCarts[index].id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            demoCarts.removeAt(index);
                          });
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              // SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(
                          cart: demoCarts[index],
                          product: demoCarts,
                        ),
                      ),
                      onTap: () {}),
                ),
              ));
  }
}

class CartCard extends StatefulWidget {
  const CartCard({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);
  final List<p.Product> product;
  final p.Product cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int addtoCart = 1;
  Widget addtoCartWi() {
    var width = MediaQuery.of(context).size.width;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
          width: width * 0.16,
          child: ElevatedButton(
            onPressed: () => setState(() {
              addtoCart = addtoCart + 1;
            }),
            child: new Text(
              "+",
              style: new TextStyle(fontSize: width * 0.07),
            ),
            // color: Colors.blueAccent,
            // textColor: Colors.white,
          ),
        ),
        new Container(
          width: width * 0.1,
          child: new Text(
            "0",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        new Container(
          width: width * 0.16,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (addtoCart == 1) {
                } else {
                  addtoCart = addtoCart - 1;
                }
              });
            },
            child: new Text(
              "-",
              style: new TextStyle(fontSize: width * 0.07),
            ),
            // color: Colors.blueAccent,
            // textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Row(
        children: [
          SizedBox(
            width: 25,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(widget.cart.images[0].src),
              ),
            ),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cart.name,
                style: TextStyle(color: Colors.black, fontSize: width * 0.05),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\₹${widget.cart.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFFFF7643)),
                  children: [
                    TextSpan(
                        text: " x2",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            children: <Widget>[
              new IconButton(
                onPressed: () => setState(() {
                  addtoCart = addtoCart + 1;
                }),
                icon: new Icon(Icons.add,
                    size: width * 0.05, color: Colors.blueAccent),
              ),
              Text(
                addtoCart == 0 ? "0" : addtoCart.toString(),
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    addtoCart == 0 ? 0 : addtoCart = addtoCart - 1;
                  });
                },
                icon: new Icon(Icons.remove,
                    size: width * 0.05, color: Colors.blueAccent),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      product: widget.cart,
                    )));
      },
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  //812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

// Demo data for our cart

class CheckoutCard extends StatelessWidget {
  List<CartProducts> cartProducts = [];
  final int addTocart;
  CheckoutCard({
    this.cartProducts,
    this.addTocart,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  // color: ,
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\₹337.15",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    child: Text("Check Out"),
                    onPressed: () {
                      // print('cartProducts: $cartProducts');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateOrder(
                                    cartProducts: cartProducts,
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
