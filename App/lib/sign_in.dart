import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'chart_info.dart';
import 'heartCustom.dart';

class SignInView extends StatelessWidget {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController emailUser = new TextEditingController();
  final TextEditingController passWordUser = new TextEditingController();

  signIn(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if (emailUser.text == "Team05@gmail.com" &&
          passWordUser.text == "123456") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LineChart(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Center(child: Text("Register")),
          )
        ],
      ),
      body: SlidingSheet(
        cornerRadius: 30,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [1, 0.6],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFEF5350),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Text("Sign In",
                      style: TextStyle(fontSize: 35, color: Colors.white)),
                ),
                AnimatedLiquidCustomProgressIndicator(),
              ],
            ),
          ),
        ),
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height / 4 * 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, left: 20.0, right: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: TextFormField(
                                  validator: (value) {
                                    return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                        ? null
                                        : "Vui lòng cung cấp một email hợp lệ";
                                  },
                                  controller: emailUser,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13.0),
                                  decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(color: Colors.blue),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          borderSide:
                                          BorderSide(color: Colors.red)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                          borderSide:
                                          BorderSide(color: Colors.blue)))),
                            ),
                            TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  return value.length >= 6
                                      ? null
                                      : "Vui lòng cung cấp mật khẩu từ 6 ký tự trở lên";
                                },
                                controller: passWordUser,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13.0),
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: Colors.blue),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide:
                                        BorderSide(color: Colors.red)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide:
                                        BorderSide(color: Colors.blue)))),
                            Container(
                              alignment: Alignment.centerRight,
                              padding:
                              const EdgeInsets.only(top: 20.0, bottom: 40),
                              child: Text("Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13.0)),
                            ),
                            GestureDetector(
                              onTap: () {
                                signIn(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 15),
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
                                child: Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:30.0,bottom: 30.0),
                              child: Divider(height: 10,color: Colors.grey,),
                            ),
                            Card(
                              shadowColor: Colors.black54,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                  AssetImage("images/facebook.png"),
                                ),
                                title: Text("Continue with Facebook",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold)),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                            Card(
                              shadowColor: Colors.black54,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: AssetImage("images/google.png"),
                                ),
                                title: Text("Continue with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.bold)),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
