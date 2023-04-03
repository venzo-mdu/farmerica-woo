import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/networks/ApiServices.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/widgets/checkout_widget.dart';
import 'package:safira_woocommerce_app/utils/sharedServices.dart';
import 'package:string_validator/string_validator.dart';

class SavedAddress extends BasePage {
  Customers customer;
  SavedAddress({this.customer});

  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends BasePageState<SavedAddress> {
  TextEditingController firstName, lastName, phoneNumber, emailAddress, streetAddress, flat, townCity, postal;
  String first, last, mail, phone, email, street, appointment, town, pinCode;
  bool b1, b2, b3, b4, b5, b6, b7, b8 = false;
  SharedServices services = SharedServices();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    Customers customer = widget.customer;
    Api_Services api_services = Api_Services();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Save Address",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b1,
                          onChanged: (valu) {
                            first = valu;
                          },
                          validator: (value) {
                            setState(() {
                              first = widget.customer.firstName;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: " First Name: "
                                  " ${customer.firstName}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: firstName,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b1 = true;
                          });
                          //  t1.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b2,
                          onChanged: (valu) {
                            last = valu;
                          },
                          validator: (value) {
                            setState(() {
                              last = widget.customer.lastName;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Last Name:"
                                  "${customer.lastName}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: lastName,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b2 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b8,
                          onChanged: (valu) {
                            mail = valu;
                          },
                          validator: (value) {
                            bool valid = isEmail(value);
                            if (valid) {
                              return null;
                            } else if (value == null || value.isEmpty) {
                              setState(() {
                                mail = widget.customer.email;
                              });
                            } else {
                              return "Enter valid Mail Id";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "${customer.email}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: emailAddress,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b8 = true;
                          });
                          //  t1.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b3,
                          onChanged: (valu) {
                            phone = valu;
                          },
                          validator: (value) {
                            setState(() {
                              phone = widget.customer.billing.phone;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Phone Number:",
                                  // "${customer.billing.phone}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: phoneNumber,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b3 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b4,
                          onChanged: (valu) {
                            street = valu;
                          },
                          validator: (value) {
                            setState(() {
                              street = widget.customer.billing.address1;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Address - 1",
                                  // "${customer.billing.address1}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: streetAddress,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b4 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b5,
                          onChanged: (valu) {
                            appointment = valu;
                          },
                          validator: (value) {
                            setState(() {
                              appointment = widget.customer.billing.address2;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Address - 2",
                                  // "${customer.billing.address2}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: streetAddress,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b5 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b6,
                          onChanged: (valu) {
                            town = valu;
                          },
                          validator: (value) {
                            setState(() {
                              town = widget.customer.billing.city;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Town",
                                  // "${customer.billing.city}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: townCity,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b6 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFFF5F6F9),
                // onPressed: press,
                child: Row(
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: Colors.redAccent,
                      size: 22,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: TextFormField(
                          autofocus: true,
                          enabled: b7,
                          onChanged: (valu) {
                            pinCode = valu;
                          },
                          validator: (value) {
                            setState(() {
                              pinCode = widget.customer.billing.postcode;
                            });
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "Pin-Code",
                                  // "${customer.billing.postcode}",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontWeight: FontWeight.bold
                              )),
                          controller: postal,
                        )),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            b7 = true;
                          });
                          // t2.value = TextEditingValue(text: "00");
                        }),
                  ],
                ),
              ),
            ),

            OpenFlutterButton(
                title: "Update",
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    Customers customers = await api_services
                        .updateCustomers(
                        firstName: first,
                        lastName: last,
                        email: mail,
                        phone: phone,
                        address_1: street,
                        address_2: appointment,
                        city: town,
                        postcode: pinCode,
                        id: widget.customer.id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: "Update Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      services.setLoginDetails(customer);
                    });
                    setState(() {
                      b1 = false;
                      b2 = false;
                      b3 = false;
                      b4 = false;
                      b5 = false;
                      b6 = false;
                      b7 = false;
                      b8 = false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
