import 'package:flutter/cupertino.dart';

import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Order.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/gertProductfromapi.dart';
import 'package:safira_woocommerce_app/models/Products.dart';

class OrderModel extends ChangeNotifier {
  List<Orders> order = [];
  Api_Services api_services = Api_Services();
  List<CartProducts> getCartProduct() {
    List<CartProducts> cartProducts = [];
    return cartProducts;
  }

  List<Product> products = [];

  getOrder(List<CartProducts> cartProducts) async {
    int i = 0;

    while (i < 2) {
      Product product =
          await api_services.getProductsById(cartProducts[i].product_id);
      i++;

      products.add(product);
    }

    return products;
  }

  addOrder(int id, int quantity) {
    notifyListeners();
  }

  removeOrder(int id, int quantity) {
    notifyListeners();
  }

  updateOrder(int id, int quantity) {
    notifyListeners();
  }

  clearCart() {
    notifyListeners();
  }
}
