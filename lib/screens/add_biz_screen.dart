import 'package:flutter/material.dart';
import 'package:ilocca_v2/styles/app_colors.dart';

String dropdownValue = 'default';

class AddNewBusiness extends StatefulWidget {
  const AddNewBusiness({super.key});

  @override
  State<AddNewBusiness> createState() => _AddNewBusinessState();
}

class _AddNewBusinessState extends State<AddNewBusiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 10,
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
                        decoration: InputDecoration(
                          hintText: "business name",
                          labelText: "Please Enter Business Name",
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
                        decoration: InputDecoration(
                          hintText: "description",
                          labelText: "A description of your business",
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
                      //drop down
                      Container(
                        width: double.infinity, // Full width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: DropdownButton(
                          padding: EdgeInsets.all(6.0),
                          isExpanded: true,
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
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

                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors
                              .transparent), // Set your desired background color
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleCreate() {
    print("create new");
  }
}
