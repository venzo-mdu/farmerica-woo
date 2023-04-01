import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/Providers/CartProviders.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/productDetails.dart';
import 'package:provider/provider.dart';

class GridViewList extends StatefulWidget {
  List<Product> product;

  GridViewList({this.product});

  @override
  State<GridViewList> createState() => _GridViewListState();
}

class _GridViewListState extends State<GridViewList> {
  int addtoCart = 0;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 5000,
        child: GridView.builder(
          itemCount: widget.product.length,
          itemBuilder: (BuildContext context, int id) {
            var width = MediaQuery.of(context).size.width;
            // print('Grid; ${widget.product.length}');
            // final sortedItems = isDropDown ? product.reversed.toList() : product;
            // final item = sortedItems[id];
            // print('sortedItems: ${item.price.toString()}');
            return GestureDetector(
                child: Container(
                  width: width * 0.5,
                  //height: width * 0.4,
                  color: Colors.white,
                  child: Card(
                      child: Column(
                        children: <Widget>[
                          new Stack(
                            children: <Widget>[
                              Container(
                                width: width * 0.30,
                                height: width * 0.20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        widget.product[id].images[0].src,
                                        // width: width * 0.3,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.product[id].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style:
                            new TextStyle(fontSize: width * 0.045),
                          ),
                          Text(
                            "₹" + widget.product[id].price,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                addtoCart = 1;
                              });

                              print('CardDetails78: ${widget.product[id].id}');



                              Provider.of<CartModel>(context,
                                  listen: false)
                                  .addCartProduct(
                                  widget.product[id].id,
                                  1,
                                  widget.product[id].name,
                                  widget.product[id].price,
                                  widget.product[id].images[0].src
                              );
                              // .addCartProduct(widget.product);
                              Fluttertoast.showToast(
                                  msg:
                                  "${widget.product[id].name} successfully added to cart",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                            child: Text("Add to Cart"),
                            // color: Colors.blueAccent,
                            // textColor: Colors.white,
                          )
                        ],
                      )),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            product: widget.product[id],
                          )));
                });
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      ),
    );
  }
}
