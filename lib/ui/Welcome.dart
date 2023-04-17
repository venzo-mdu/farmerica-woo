import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:safira_woocommerce_app/constant.dart';

import 'package:safira_woocommerce_app/ui/LoginPage.dart';

import 'package:safira_woocommerce_app/ui/SignUp.dart';

import 'package:safira_woocommerce_app/ui/widgets/mytextbutton.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Flexible(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image(
                              image: NetworkImage('https://www.farmerica.in/wp-content/uploads/2023/01/farmerica-logo.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Farmerica",
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 26),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            "We are Farmerica: value added and natural grown agriculture and horticulture Solutions Provider.",
                            style: kBodyText,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextButton(
                            bgColor: Colors.white,
                            buttonName: 'Register',
                            onTap: () {
                              // Customers customer = Customers();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            textColor: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: MyTextButton(
                            bgColor: Colors.transparent,
                            buttonName: 'Sign In',
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
