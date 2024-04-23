import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilocca_v2/controllers/business_edit_controller.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/screens/register_screen.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

String dropdownValue = 'default';

String locationValue = 'default';

String profile = "";

bool isLoading = false;

//acces the userdetails state
UserDetailsController userDetailsController = Get.put(UserDetailsController());

dynamic creatorUsernameValue = userDetailsController.username.value;
dynamic creatorPhoneValue = userDetailsController.phone.value;

//controllers to track inputs on text fields
TextEditingController phoneController = TextEditingController();

class EditUserScreen extends StatefulWidget {
  EditUserScreen({Key? key}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  File? _image;
  CloudinaryPublic cloudinary =
      CloudinaryPublic('ddyw2aavm', 'flutterilocca', cache: false);

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      _image = pickedImage != null ? File(pickedImage.path) : null;
    });

    if (_image != null) {
      _uploadImageToCloudinary();
    }
  }

  Future<void> _uploadImageToCloudinary() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_image!.path,
            resourceType: CloudinaryResourceType.Image),
      );
      // Handle the response here
      print("Uploaded image URL: ${response.secureUrl}");
      setState(() {
        isLoading = false;
      });
      profile = response.secureUrl;
    } catch (e) {
      // Handle upload errors
      setState(() {
        isLoading = false;
      });
      print("Error uploading image: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize values from controller or other sources if necessary
    phoneController.text = userDetailsController.phone.value;
    photoValue = userDetailsController.profile.value;
    locationValue = userDetailsController.location.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "phone number",
                  labelText: "Edit Phone Number",
                  labelStyle: TextStyle(
                    // color: Colors.white.withOpacity(0.4),
                    fontSize: 20,
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        // color: Colors.white,
                        ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // Image picker button
              ElevatedButton(
                onPressed: () {
                  _showImagePickerDialog();
                },
                child: const Text("Update Profile"),
              ),

              /// Display selected image

              isLoading
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: primaryTxtColor, size: 50),
                    )
                  : _image != null
                      ? Image.file(
                          _image!,
                          height: 100,
                          width: 100,
                        )
                      : Container(),

              photoValue != null && _image == null
                  ? Image.network(photoValue, height: 100, width: 100)
                  : Container(),

              const SizedBox(
                height: 16,
              ),

              //drop down for location
              Container(
                width: double.infinity, // Full width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: DropdownButton(
                  padding: const EdgeInsets.all(6.0),
                  isExpanded: true,
                  value: locationValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  underline: Container(),
                  // style: TextStyle(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                  elevation: 16,
                  // dropdownColor: Colors.black.withOpacity(0.8),
                  onChanged: (String? newValue) {
                    setState(() {
                      locationValue = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: "default",
                      child: Text("Choose location"),
                    ),
                    DropdownMenuItem(
                      value: "daystar",
                      child: Text("Daystar Athi"),
                    ),
                    DropdownMenuItem(
                      value: "kitengela",
                      child: Text("Kitengela"),
                    ),
                    DropdownMenuItem(
                      value: "syokimau",
                      child: Text("Syokimau"),
                    ),
                    DropdownMenuItem(
                      value: "thika",
                      child: Text("Thika"),
                    ),
                    DropdownMenuItem(
                      value: "other",
                      child: Text("Other"),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              isLoading
                  ? Center(
                      child: Column(
                        children: [
                          LoadingAnimationWidget.newtonCradle(
                              color: primaryTxtColor, size: 50),
                          const Text("Please wait")
                        ],
                      ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all<Color>(Colors
                        //     .transparent), // Set your desired background color
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 0)),
                      ),
                      onPressed: () {
                        checkAllDetails();
                      },
                      child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Update Acount",
                              style: TextStyle(
                                  color: primaryTxtColor, fontSize: 20),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              color: primaryTxtColor,
                            )
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void checkAllDetails() {
    if (phoneController.text.isEmpty) {
      showingDialogMsg("Creation Error", "Title Missing");
      return;
    }

    if (locationValue.isEmpty) {
      showingDialogMsg("Creation Error", "Location Missing");
      return;
    }
    if (photoValue.isEmpty) {
      showingDialogMsg("Creation Error", "Photo Missing");
      return;
    }

    handleUpdate();
  }

  Future<void> handleUpdate() async {
    setState(() {
      isLoading = true;
    });
    var response = await updateAccount();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed("/main");
      showingDialogMsg("Update Success 🎉", "Updated profile");
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to add. Status code: ${response.statusCode}');
      showingDialogMsg("Update Error", "Error Updating Account");
    }
  }

  Future<http.Response> updateAccount() async {
    final url = Uri.parse('$base_url/users/${userDetailsController.userId}');
    // Prepare the body
    final body = jsonEncode({
      'phone': phoneController.text,
      'profile': photoValue,
      'location': locationValue,
    });

    // Prepare the headers
    final headers = {'Content-Type': 'application/json'};

    // print(body);

    // Make the put request
    return http.put(url, headers: headers, body: body);
  }

  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }

  //for showing messages
  Future<dynamic> showingDialogMsg(String title, String msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
          ),
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
