import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

String dropdownValue = 'default';

String locationValue = 'default';

String photoValue = "";

//controllers to track inputs on text fields
TextEditingController bizTitleController = TextEditingController();
TextEditingController bizDescController = TextEditingController();

//acces the userdetails state
UserDetailsController userDetailsController = Get.put(UserDetailsController());

dynamic creatorUsernameValue = userDetailsController.username.value;
dynamic creatorPhoneValue = userDetailsController.phone.value;

class AddNewBusiness extends StatefulWidget {
  const AddNewBusiness({super.key});

  @override
  State<AddNewBusiness> createState() => _AddNewBusinessState();
}

class _AddNewBusinessState extends State<AddNewBusiness> {
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
      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(_image!.path,
            resourceType: CloudinaryResourceType.Image),
      );
      // Handle the response here
      print("Uploaded image URL: ${response.secureUrl}");
      photoValue = response.secureUrl;
    } catch (e) {
      // Handle upload errors
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 14,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Card(
                // margin: EdgeInsets.only(top: 100),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "Add A New Business",
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
                          controller: bizTitleController,
                          decoration: const InputDecoration(
                            hintText: "business name",
                            labelText: "Please Enter Business Name",
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

                        TextField(
                          controller: bizDescController,
                          decoration: const InputDecoration(
                            hintText: "description",
                            labelText: "A description of your business",
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
                        //drop down
                        Container(
                          width: double.infinity, // Full width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: DropdownButton(
                            padding: const EdgeInsets.all(6.0),
                            isExpanded: true,
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            underline: Container(),
                            // style: TextStyle(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                            elevation: 16,
                            // dropdownColor: Colors.black.withOpacity(0.8),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "default",
                                child: Text("Best Category For Your Biz"),
                              ),
                              DropdownMenuItem(
                                value: "fashion",
                                child: Text("Fashion"),
                              ),
                              DropdownMenuItem(
                                value: "fun",
                                child: Text("Fun"),
                              ),
                              DropdownMenuItem(
                                value: "transport",
                                child: Text("Transport"),
                              ),
                              DropdownMenuItem(
                                value: "laundry",
                                child: Text("Laundry"),
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

                        // Image picker button
                        ElevatedButton(
                          onPressed: () {
                            _showImagePickerDialog();
                          },
                          child: Text("Pick Image"),
                        ),

                        /// Display selected image
                        _image != null
                            ? Image.file(
                                _image!,
                                height: 100,
                                width: 100,
                              )
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

                        ElevatedButton(
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
                                  "Add New Business",
                                  style: TextStyle(
                                      color: primaryTxtColor, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.add,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkAllDetails() {
    if (bizTitleController.text.isEmpty) {
      showingDialogMsg("Creation Error", "Title Missing");
      return;
    }

    if (bizDescController.text.isEmpty) {
      showingDialogMsg("Creation Error", "Title Missing");
      return;
    }
    if (dropdownValue.isEmpty) {
      showingDialogMsg("Creation Error", "Category Missing");
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
    if (creatorUsernameValue.isEmpty) {
      showingDialogMsg("Creation Error", "Owner Missing");
      return;
    }
    if (creatorPhoneValue.isEmpty) {
      showingDialogMsg("Creation Error", "Owner phone Missing");
      return;
    }

    handleCreate();
  }

  Future<void> handleCreate() async {
    var response = await addNewBiz();
    if (response.statusCode == 200) {
      showingDialogMsg("Creation Success 🎉", "Added New");
      // Navigator.of(context).pushReplacementNamed("/");
    } else {
      print('Failed to add. Status code: ${response.statusCode}');
      showingDialogMsg("Addition Error", "Error adding biz");
    }
  }

  Future<http.Response> addNewBiz() async {
    final url = Uri.parse('$base_url/biz');
    // Prepare the body
    final body = jsonEncode({
      'title': bizTitleController.text,
      'business_desc': bizDescController.text,
      'photo': photoValue,
      'category': dropdownValue,
      'business_location': locationValue,
      'phone': creatorPhoneValue,
      'business_owner': creatorUsernameValue,
    });

    // Prepare the headers
    final headers = {'Content-Type': 'application/json'};

    print(body);

    // Make the POST request
    return http.post(url, headers: headers, body: body);
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
