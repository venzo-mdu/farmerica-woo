import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:safira_woocommerce_app/form_helper.dart';
import 'package:safira_woocommerce_app/models/CartRequest.dart';
import 'package:safira_woocommerce_app/models/Customers.dart';
import 'package:safira_woocommerce_app/models/Products.dart';
import 'package:safira_woocommerce_app/ui/BasePage.dart';
import 'package:safira_woocommerce_app/ui/verifyAddress.dart';
import 'package:string_validator/string_validator.dart';
// import 'package:intl/intl.dart';

class CreateOrder extends BasePage {
  List<CartProducts> cartProducts;
  List<Product> product = [];
  final int id;
  var shippingFee;
  CreateOrder({this.cartProducts, this.product, this.id, this.shippingFee});
  @override
  _CreateOrderState createState() => _CreateOrderState();
}

class _CreateOrderState extends BasePageState<CreateOrder> {
  final _formKey = GlobalKey<FormState>();
  Customers details;
  String first,
      last,
      city,
      state,
      postcode,
      apartmnt,
      flat,
      address,
      country,
      mobile,
      mail;
  int selected = 2;
  String title = "Create Order";
  String dropDownValue;
  // BasePage basePage = BasePage();
  @override
  void initState() {
    super.initState();
    // basePage.title = "Checkout Page";
    // basePage.selected = 2;
    print('objectUser: ${widget.id}');
    print('widget.shipping: ${widget.shippingFee}');
  }
  TextEditingController datePickerController = TextEditingController();

  @override
  Widget body(BuildContext context) {
    print(widget.product);
    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Choose Delivery Date"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: datePickerController,
                      decoration: InputDecoration(
                        labelText: 'Dates',
                        hintText: DateFormat.yMd().format(DateTime.now()),
                      ),

                      onChanged: (value) async {},

                      onTap: () async {
                        DateTime dateTime = DateTime.now();
                        DateTime now = DateTime.now();
                        dynamic hours = DateFormat.jm().format(now);
                        print('${DateFormat.jm().format(now)}');

                        if(widget.shippingFee == 75) {
                          print('objectError: ${hours.runtimeType}');

                          // 12.00 am      // 7
                          // if(hours <= Convert.ToDateTime('5:30 AM') && hours <= '18') {
                          //   print(hours);
                          //   print("Good Morning");
                          //   print("Deliverable");
                          //
                          // } else {
                          //   print("Not Deliverable");
                          // }
                          ///
                          // else if(hours <= 6 && hours >= 7) {
                          //   print('objectDeliver');
                          // }


                          // else if(hours>=12 && hours<=16) {
                          //   print("Good Afternoon");
                          // } else if(hours>=16 && hours<=21) {
                          //   print("Good Evening");
                          // } else if(hours>=21 && hours<=24){
                          //   print("Good Night");
                          // }
                        }


                        final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: dateTime,
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101));
                        if (picked != null) {
                          dateTime = picked;
                          //assign the chosen date to the controller
                          datePickerController.text = DateFormat.yMd().format(dateTime);
                          print('objectDatePickerController: ${datePickerController.text}');
                        }
                      },
                    ),
                  )
                ],
              ),

              widget.shippingFee == 0 ? Row(
                children: [
                  DropdownButton<String>(
                    value: dropDownValue,
                    items: <String>[
                      '08:00 AM - 01:00 PM',
                      '01:00 PM - 06:00 PM',
                      '06:00 PM - 09:00 PM',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (onChangedValue) {
                      setState(() {
                        dropDownValue = onChangedValue;
                      });
                    },
                  )
                ],
              ) : Container(),

              Row(
                children: [

                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("First Name"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Last Name"),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "First Name",
                        labelText: "First Name",
                        helperText: "Fist Name",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        first = value;
                        print(first);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        labelText: "Last Name",
                        helperText: "Last Name",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        print(value);
                        last = value;
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid last name";
                        }
                      },
                    ),
                  ),
                ],
              ),
              FormHelper.fieldLabel("Address"),
              TextFormField(
                initialValue: "",
                decoration: InputDecoration(
                  hintText: "Address",
                  labelText: "Address",
                  helperText: "Address",
                ),
                maxLines: 2,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  address = value;
                  print(address);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              FormHelper.fieldLabel("Apartmnt ,Flat"),
              TextFormField(
                initialValue: "",
                decoration: InputDecoration(
                  hintText: "Apartmnt ,Flat",
                  labelText: "Apartmnt ,Flat",
                  helperText: "Apartmnt ,Flat",
                ),
                maxLines: 1,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  apartmnt = value;
                  return;
                  print(apartmnt);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Country"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("State"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Country",
                        labelText: "Country",
                        helperText: "Country",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        country = value;
                        print(country);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid  country";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "State",
                        labelText: "State",
                        helperText: "State",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        state = value;
                        print(state);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("City"),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("PostCode"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "City",
                        labelText: "City",
                        helperText: "City",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        city = value;
                        print(city);
                      },
                      validator: (value) {
                        bool valid = isAlpha(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid name";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "PostCode",
                        labelText: "PostCode",
                        helperText: "Post Code",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        postcode = value;
                        print(postcode);
                      },
                      validator: (value) {
                        bool valid = isNumeric(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid PostCode";
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Mobile No."),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FormHelper.fieldLabel("Mail Id"),
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Mobile",
                        labelText: "Mobile",
                        helperText: "Mobile",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        mobile = value;
                        print(first);
                      },
                      validator: (value) {
                        bool valid = isLength(value, 10);
                        bool vali = isNumeric(value);
                        if (valid && vali) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (vali) {
                          return "Enter valid no.";
                        } else if (valid) {
                          return "Enter 10 digit No.";
                        }
                      },
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: TextFormField(
                      initialValue: "",
                      decoration: InputDecoration(
                        hintText: "Mail Id",
                        labelText: "Mail Id",
                        helperText: "Mail Id",
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (String value) {
                        print(value);
                        mail = value;
                      },
                      validator: (value) {
                        bool valid = isEmail(value);
                        if (valid) {
                          return null;
                        } else if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else {
                          return "Enter valid Mail Id";
                        }
                      },
                    ),
                  ),
                ],
              ),
              Center(
                child: FormHelper.saveButton("Next", () {
                  if (_formKey.currentState.validate()) {




                    var data = '2023-03-31';
                    var day = data.substring(8, 10);
                    var month = data.substring(5, 7);
                    var year = data.substring(0, 4);
                    final intDay = int.parse(day);
                    final intMonth = int.parse(month);
                    final intYear = int.parse(year);
                    final formattedDate = DateTime.utc(intYear, intMonth, intDay);
                    print("formattedDate:$formattedDate");
                    final format = DateFormat.yMd().format(formattedDate);
                    print('format:$format');


                    if(datePickerController.text == DateFormat('EEEE').format(DateTime.now())) {
                      print('objectError');
                    } else {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyAddress(
                                    product: widget.product,
                                    id: widget.id,
                                    first: first,
                                    last: last,
                                    address: address,
                                    apartmnt: apartmnt,
                                    state: state,
                                    city: city,
                                    country: country,
                                    postcode: postcode,
                                    cartProducts: widget.cartProducts,
                                    mobile: mobile,
                                    mail: mail,
                                    deliveryDate: datePickerController.text,
                                    deliveryTime: dropDownValue,

                                  )));
                    }
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
