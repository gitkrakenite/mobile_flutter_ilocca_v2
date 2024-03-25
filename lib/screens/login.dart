import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:ilocca_v2/utils/sharedpreferences.dart';
import 'package:http/http.dart' as http;

bool showPass = false;

//shared preferences object
//we have two functions. read and write
MysharedPreferences myPref = MysharedPreferences();

//controllers to track inputs on text fields
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

//to access the state we initialize the constructor
UserDetailsController userDetailsController = Get.put(UserDetailsController());

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //we can now read values from sharedpreferences
    //the key must be what you had when writing
    //since we are reading from the futre and not immediately we need .then
    myPref.getValue("username").then(
          (value) => {usernameController.text = value},
        );

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
                        elevation: 1,
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
                                      controller: usernameController,
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
                                      controller: passwordController,
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
                                        checkUserDetails();
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
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  "/register");
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

  Future<void> login() async {
    var response = await loginUser();
    if (response.statusCode == 200) {
      // Parse the JSON response body
      var jsonResponse = jsonDecode(response.body);

      // Extract username and phone from the JSON response
      String username = jsonResponse['username'];
      String phone = jsonResponse['phone'];
      String userId = jsonResponse['user_id'].toString();

      userDetailsController.updateUserDetails(username, phone, userId);

      //we are going to store username and phone locally in sharedPreferences
      myPref.writeValue("username", usernameController.text);

      Navigator.of(context).pushReplacementNamed("/main");
    } else {
      print('Failed to login user. Status code: ${response.statusCode}');
      showingDialogMsg("Login Error", "Incorrect Username or Password");
    }
  }

  checkUserDetails() {
    if (usernameController.text.isEmpty) {
      showingDialogMsg("Login Error", "Username Missing");
      return;
    }

    if (passwordController.text.isEmpty) {
      showingDialogMsg("Login Error", "Password Missing");
      return;
    }

    login();
  }

  Future<http.Response> loginUser() async {
    final url = Uri.parse('$base_url/users/login');
    // Prepare the body
    final body = jsonEncode({
      'username': usernameController.text,
      'user_pwd': passwordController.text,
    });

    // Prepare the headers
    final headers = {'Content-Type': 'application/json'};

    // Make the POST request
    return http.post(url, headers: headers, body: body);
  }

  Future<dynamic> showingDialogMsg(String title, String msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
