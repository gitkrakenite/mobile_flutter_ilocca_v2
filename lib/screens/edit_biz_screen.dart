import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilocca_v2/controllers/business_edit_controller.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

//access current biz via controller

String dropdownValue = 'default';

String locationValue = 'default';

String photoValue = "";

bool isLoading = false;

//acces the userdetails state
UserDetailsController userDetailsController = Get.put(UserDetailsController());

dynamic creatorUsernameValue = userDetailsController.username.value;
dynamic creatorPhoneValue = userDetailsController.phone.value;

//acces the biz state
BusinessEditController editBizController = Get.put(BusinessEditController());

//controllers to track inputs on text fields
TextEditingController bizTitleController = TextEditingController();
TextEditingController bizDescController = TextEditingController();

class EditMyBusinnes extends StatefulWidget {
  EditMyBusinnes({Key? key}) : super(key: key);

  @override
  State<EditMyBusinnes> createState() => _EditMyBusinnesState();
}

class _EditMyBusinnesState extends State<EditMyBusinnes> {
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
      photoValue = response.secureUrl;
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
    bizTitleController.text = editBizController.title.value;
    bizDescController.text = editBizController.business_desc.value;
    dropdownValue = editBizController.category.value;
    photoValue = editBizController.photo.value;
    locationValue = editBizController.business_location.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${editBizController.title.value}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
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
                child: Text("Update Image"),
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
                              "Update Business",
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

    handleUpdate();
  }

  Future<void> handleUpdate() async {
    setState(() {
      isLoading = true;
    });
    var response = await updateBiz();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed("/allbiz");
      showingDialogMsg(
          "Update Success 🎉", "Updated ${editBizController.title.value}");
    } else {
      setState(() {
        isLoading = false;
      });
      print('Failed to add. Status code: ${response.statusCode}');
      showingDialogMsg("Update Error", "Error Updating biz");
    }
  }

  Future<http.Response> updateBiz() async {
    final url =
        Uri.parse('$base_url/biz/${editBizController.business_id.value}');
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
