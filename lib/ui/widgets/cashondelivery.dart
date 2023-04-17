import 'package:flutter/material.dart';
import 'package:safira_woocommerce_app/models/Order.dart' as o;

class CashOnDelivery extends StatefulWidget {
  // o.Orders state;
  // List product = [];

  @override
  State<CashOnDelivery> createState() => _CashOnDeliveryState();
}

class _CashOnDeliveryState extends State<CashOnDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text('Your Order is Placed'))
            ],
          ),
        ),
      ),
    );
  }
}
