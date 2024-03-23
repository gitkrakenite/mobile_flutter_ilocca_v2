import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

bool showPass = false;

class RegisterSceen extends StatefulWidget {
  const RegisterSceen({super.key});

  @override
  State<RegisterSceen> createState() => _RegisterSceenState();
}

class _RegisterSceenState extends State<RegisterSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/images/iloccaBg.jpg",
                  fit: BoxFit
                      .cover, // This ensures the image fills the entire space
                  height: double.infinity,
                ),

                //background overlay
                Container(
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.9),
                ),

                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.only(top: 210),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Create An Account",
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: darkBgColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "username",
                                          labelText: "Create Username",
                                          labelStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 20,
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: "phone",
                                          labelText: "Enter Phone Number",
                                          labelStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 20,
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextField(
                                        obscureText: showPass ? false : true,
                                        decoration: InputDecoration(
                                          hintText: "password",
                                          labelText: "Create Password",
                                          labelStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 20,
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                showPass = !showPass;
                                              });
                                            },
                                            icon: Icon(showPass
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(Colors
                                                  .transparent), // Set your desired background color
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  Size(double.infinity, 0)),
                                        ),
                                        onPressed: () {
                                          Register();
                                        },
                                        child: const Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Create Account",
                                                style: TextStyle(
                                                  color: primaryTxtColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                Icons.login,
                                                color: primaryTxtColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: TextButton(
                                          onPressed: () {
                                            Get.offAndToNamed("/");
                                          },
                                          child: const Text(
                                              "Already Have Account"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Register() {
    Get.offAndToNamed("/home");
  }
}
