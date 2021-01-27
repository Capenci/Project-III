import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:smart_healthcare/sign_in.dart';

class SplashScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E7),
      body: SlidingSheet(
        cornerRadius: 30,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.4, 0.7, 1.0],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/logo.png"), fit: BoxFit.cover)),
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Color(0xFFEF5350)),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text("Welcome",
                          style: TextStyle(fontSize: 35, color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Text(
                          "This is software to take care and monitor the user's health.",
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInView()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF64B5F6),
                                    blurRadius: 4.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                                shape: BoxShape.rectangle,
                                color: Color(0xFF64B5F6)),
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 4.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30),
                              shape: BoxShape.rectangle,
                              color: Colors.white),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
