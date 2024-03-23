import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:image_picker/image_picker.dart';

String dropdownValue = 'default';

class AddNewBusiness extends StatefulWidget {
  const AddNewBusiness({super.key});

  @override
  State<AddNewBusiness> createState() => _AddNewBusinessState();
}

class _AddNewBusinessState extends State<AddNewBusiness> {
  File? _image;

  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedImage = await ImagePicker().pickImage(source: source);

  //   setState(() {
  //     _image = pickedImage != null ? File(pickedImage.path) : null;
  //   });
  // }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      _image = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                // margin: EdgeInsets.only(top: 100),
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
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
                        const TextField(
                          decoration: InputDecoration(
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
                        const TextField(
                          decoration: InputDecoration(
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

                        ElevatedButton(
                          style: ButtonStyle(
                            // backgroundColor: MaterialStateProperty.all<Color>(Colors
                            //     .transparent), // Set your desired background color
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(double.infinity, 0)),
                          ),
                          onPressed: () {
                            handleCreate();
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

  void handleCreate() {
    print("create new");
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
}
