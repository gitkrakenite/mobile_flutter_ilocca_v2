import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

bool showPass = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  "https://images.pexels.com/photos/2657669/pexels-photo-2657669.jpeg?auto=compress&cs=tinysrgb&w=600",
                  fit: BoxFit
                      .cover, // This ensures the image fills the entire space
                  height: double.infinity,
                ),

                //background overlay
                Container(
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.9),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
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
                                      "Please Login",
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
                                        labelText: "Please Enter Username",
                                        labelStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
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
                                        labelText: "Enter Password",
                                        labelStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.4),
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
                                        login();
                                      },
                                      child: const Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Login Now",
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
                                          Get.offAndToNamed("/register");
                                        },
                                        child: const Text("No Account Yet"),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  login() {
    Get.offAndToNamed("/home");
  }
}
