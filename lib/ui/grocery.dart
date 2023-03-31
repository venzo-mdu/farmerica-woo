import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/ui/CartPage.dart';
import 'package:safira_woocommerce_app/ui/gridViewList.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:safira_woocommerce_app/ui/widgets/component.dart';
import 'package:provider/provider.dart';

class Grocery extends BasePage {
  Grocery({this.product});

  List<Product> product;

  @override
  _GroceryState createState() => _GroceryState();
}

class _GroceryState extends BasePageState<Grocery> {
  int selected = 1;
  String title = "aa";
  int addtoCart = 0;
  var isSelectedDropDown;
  bool isDropDown = false;
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    List<Product> product = widget.product;
    // print('grocery: ${widget.product.length}');

    List dummyProduct = product;
    lowToHigh() {
      for (int i = 0; i < dummyProduct.length - 1; i++){
        for (int j = 0; j < dummyProduct.length - i -1; j++){
          // print('dummyProductPrice: ${double.parse((dummyProduct[j].price))}');
          // print('dummyProductPriceType: ${double.parse((dummyProduct[j].price)).runtimeType}');
          if (double.parse((dummyProduct[j].price)) > double.parse(dummyProduct[j+1].price)) {
            // print('insideSwap:');

            var temp = dummyProduct[j];
            dummyProduct[j] = dummyProduct[j+1];
            dummyProduct[j+1] = temp;
            // print('temp: $temp');
          }
        }
      }
      // print('calling GridList53:${dummyProduct.length}');
      // print('objectDummyProduct: ${dummyProduct.length}');
      for(int i =0; i<dummyProduct.length; i++) {
        // print('objectDummyProduct: ${dummyProduct[i].price.toString()}');
      }
      GridViewList(product: dummyProduct);
    }

    highToLow() {
      // List dummyProduct = product;
      // print('dummyProduct: $dummyProduct');

      for (int i = 0; i < dummyProduct.length - 1; i++){
        for (int j = 0; j < dummyProduct.length - i -1; j++){
          // print('dummyProductPrice: ${double.parse((dummyProduct[j].price))}');
          // print('dummyProductPriceType: ${double.parse((dummyProduct[j].price)).runtimeType}');
          if (double.parse((dummyProduct[j].price)) < double.parse(dummyProduct[j+1].price)) {
            var temp = dummyProduct[j];

            dummyProduct[j] = dummyProduct[j+1];
            dummyProduct[j+1] = temp;
            // print('temp: $temp');
          }
        }
      }
      // print('calling GridList75:${dummyProduct.length}');

      // print('objectDummyProduct: ${dummyProduct.length}');
      // print('objectDummyProduct: ${dummyProduct[0].price.toString()}');
      GridViewList(product: dummyProduct);
    }


    latest() {
      // List dummyProduct = product;
      // print('CallingLatest: $dummyProduct');
      for (int i = 0; i < dummyProduct.length - 1; i++){
        for (int j = 0; j < dummyProduct.length - i -1; j++){
          // print('dummyProductPrice: ${double.parse((dummyProduct[j].price))}');
          // print('dummyProductPriceType: ${double.parse((dummyProduct[j].dateModified)).runtimeType}');
          // if (dummyProduct[j].dateModified < dummyProduct[j+1].dateModified) {
          if(dummyProduct[j].dateModified.compareTo(dummyProduct[j+1].dateModified) < 0) {
            // print('callingLastestInsideIf');
            var temp = dummyProduct[j];

            dummyProduct[j] = dummyProduct[j+1];
            dummyProduct[j+1] = temp;
            // print('temp: $temp');
          }
        }
      }
      // print('calling GridList75:${dummyProduct.length}');

      // print('objectDummyProduct: ${dummyProduct.length}');
      // print('objectDummyProduct: ${dummyProduct[0].price.toString()}');
      GridViewList(product: dummyProduct);
    }

    sorting() {
      for (int i = 0; i < dummyProduct.length - 1; i++){
        for (int j = 0; j < dummyProduct.length - i - 1; j++) {

        }
      }
    }


    return product == []
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text('Showing all ${widget.product.length} products'),
                      ),

                      DropdownButton(
                        hint: Text("Please select value"),
                        value: isSelectedDropDown,
                        items: <String>[
                          // 'Sort by Popularity',
                          'Sort by Latest',
                          'Sort by Low to High',
                          'Sort by High to Low',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            // print('isSelectedDropDown: $isSelectedDropDown');
                            // print('isSelectedDropDown: ${isSelectedDropDown.runtimeType}');
                            // print('isSelectedDropDown: $value');

                            if(value == 'Sort by Low to High') {
                              setState(() {
                                lowToHigh();
                                // isDropDown=true;
                                // print('isDropDown: $isDropDown');
                              });
                            } else if(value == 'Sort by High to Low') {
                              setState(() {
                                highToLow();
                                // isDropDown=false;
                                // print('isDropDown: $isDropDown');
                              });
                            } else {
                              setState(() {
                                latest();
                              });

                            }
                          });
                        },
                      )

                    ],
                  ),

                  GridViewList(product: product,)
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 5000,
                  //   child: GridView.builder(
                  //     itemCount: widget.product.length,
                  //     itemBuilder: (BuildContext context, int id) {
                  //       var width = MediaQuery.of(context).size.width;
                  //
                  //       // final sortedItems = isDropDown ? product.reversed.toList() : product;
                  //       // final item = sortedItems[id];
                  //       // print('sortedItems: ${item.price.toString()}');
                  //
                  //       return GestureDetector(
                  //           child: Container(
                  //             width: width * 0.5,
                  //             //height: width * 0.4,
                  //             color: Colors.white,
                  //             child: Card(
                  //                 child: Column(
                  //                   children: <Widget>[
                  //                     new Stack(
                  //                       children: <Widget>[
                  //                         Container(
                  //                           width: width * 0.30,
                  //                           height: width * 0.20,
                  //                           decoration: BoxDecoration(
                  //                             image: DecorationImage(
                  //                                 fit: BoxFit.fill,
                  //                                 image: NetworkImage(
                  //                                   widget.product[id].images[0].src,
                  //
                  //                                   // width: width * 0.3,
                  //                                 )),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     Text(
                  //                       widget.product[id].name,
                  //                       overflow: TextOverflow.ellipsis,
                  //                       maxLines: 2,
                  //                       style:
                  //                       new TextStyle(fontSize: width * 0.045),
                  //                     ),
                  //                     Text(
                  //                       "₹" + widget.product[id].price,
                  //                       style: new TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                           fontSize: width * 0.05),
                  //                     ),
                  //                     TextButton(
                  //                       onPressed: () {
                  //                         setState(() {
                  //                           addtoCart = 1;
                  //                         });
                  //
                  //                         Provider.of<CartModel>(context,
                  //                             listen: false)
                  //                             .addCartProduct(widget.product[id].id, 1);
                  //                         Fluttertoast.showToast(
                  //                             msg:
                  //                             "${widget.product[id].name} successfully added to cart",
                  //                             toastLength: Toast.LENGTH_SHORT,
                  //                             gravity: ToastGravity.BOTTOM,
                  //                             timeInSecForIosWeb: 1,
                  //                             backgroundColor: Colors.black,
                  //                             textColor: Colors.white,
                  //                             fontSize: 16.0);
                  //                       },
                  //                       child: new Text("View"),
                  //                       // color: Colors.blueAccent,
                  //                       // textColor: Colors.white,
                  //                     )
                  //                   ],
                  //                 )),
                  //           ),
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: (context) => ProductDetail(
                  //                       product: widget.product[id],
                  //                     )));
                  //           });
                  //     },
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
  }
}

