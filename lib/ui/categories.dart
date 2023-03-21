import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/Config.dart';
import 'package:safira_woocommerce_app/models/Category.dart';
import 'package:safira_woocommerce_app/models/ParentCategory.dart' as p;
import 'package:safira_woocommerce_app/models/ParentCategory.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/networks/Authorization.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/Recommendedforyou.dart';

import 'package:safira_woocommerce_app/ui/gertProductfromapi.dart';
import 'package:safira_woocommerce_app/ui/grocery.dart';
import 'package:safira_woocommerce_app/ui/vegetable.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends BasePage {
  final catergories;
  final product;
  var imageURL;
  CategoryPage({
    this.catergories,
    this.product,
    this.imageURL,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends BasePageState<CategoryPage> {
  /** */
  Api_Services api_services = Api_Services();
  BasePage basePage = BasePage();

  // getData() async {
  //   WooCommerceAPI api;
  //
  //   var url = ""
  //       "${Config.url}"
  //       "${Config.urlfor}"
  //       "${Config.productUrl}?"
  //       "category=${86}&"
  //       "consumer_key=${Config.key}&"
  //       "consumer_secret=${Config.secret}";
  //
  //   print('getData: ${url}');
  //
  //   var response = await api.getAsync(url);
  //
  //
  //   // final response = await http.get(Uri.parse(url);
  //
  //   // final response = await http.get(
  //   //     Uri.parse(url),
  //     // headers: {
  //     //   HttpHeaders.contentTypeHeader: 'application/json',
  //     // }
  //   // print('ourResponse : ${response}');
  //   // );
  //
  //   print('ourResponse : $response');
  //
  //   List<Product> data = <Product>[];
  //
  //   if(response.statusCode == 200) {
  //     data = (response.body as List)
  //         .map((e) => Product.fromJson(e),
  //     ).toList();
  //   }
  //
  //   print('ListData: $data');
  //   print(response.body);
  //   print('ListJson: ${json.decode(response.body)}');
  //
  //   return json.decode(response.body);
  // }

  @override
  void initState() {
    super.initState();
    // getData();
    // basePage.title = "My Cart";
    // basePage.selected = 2;
  }

  int selected = 2;
  String title = "Categories";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    List<p.ParentCategory> catergories = widget.catergories;
    print('catergories.length: ${catergories.length}');
    print("ww");
    print(widget.catergories);
    return categories.length == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              padding: EdgeInsets.all(4),
              margin: EdgeInsets.all(3),
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3,
                ),
                scrollDirection: Axis.vertical,
                itemCount: catergories.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  final category = catergories[i];
                  final padding = (i == 0) ? 10.0 : 0.0;
                  return GestureDetector(
                    onTap: () {
                      if (i == 0) {
                        print(i);
                        print('widget.productCategory: ${widget.product}');

                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Grocery(
                                      product: widget.product,
                                    )));
                      }
                      if (i == 1) {
                        print(i);
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Vegetable(
                                      product: widget.product,
                                    )));
                      }
                      if (i == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (context) => CategoryPage(
                                //   catergories: 101,
                                //   product: widget.product,
                                // ),
                                builder: (context) =>
                                    Recommendations(product: widget.product)));
                      }
                    },
                    child: new Container(
                      margin: EdgeInsets.only(left: padding),
                      height: width * 0.2,
                      child: new Column(
                        children: <Widget>[
                          new Image.network(
                            // category.image.src.toString() ??
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/2048px-No_image_available.svg.png',
                            height: width * 0.18,
                          ),
                          new Text(
                            category.name,
                            style: new TextStyle(
                                fontSize: width * 0.035,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
