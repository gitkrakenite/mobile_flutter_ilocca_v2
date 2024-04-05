import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilocca_v2/controllers/business_edit_controller.dart';
import 'package:ilocca_v2/controllers/user_controller.dart';
import 'package:ilocca_v2/screens/login.dart';
import 'package:ilocca_v2/styles/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:ilocca_v2/utils/base_url.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

//acces the userdetails state
UserDetailsController userDetailsController = Get.put(UserDetailsController());

//to access the state we initialize the constructor
BusinessEditController editBizController = Get.put(BusinessEditController());

bool isLoading = false;

dynamic currentBizId = 0;

class SpecificBusiness extends StatefulWidget {
  final String title;
  final String photo;
  final String owner;
  final dynamic business_id;
  final String business_desc;
  final String category;
  final String business_location;
  final String phone;

  const SpecificBusiness({
    super.key,
    required this.title,
    required this.photo,
    required this.owner,
    this.business_id,
    required this.business_desc,
    required this.category,
    required this.business_location,
    required this.phone,
  });

  @override
  State<SpecificBusiness> createState() => _SpecificBusinessState();
}

class _SpecificBusinessState extends State<SpecificBusiness> {
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                widget.photo,
                height: 220.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Owner: ${widget.owner}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: primaryTxtColor,
                ),
                const SizedBox(width: 10),
                Text(widget.business_location),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await EasyLauncher.call(number: widget.phone);
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: primaryTxtColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(widget.phone),
                  ],
                ),
                Text("#${widget.category}"),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.business_desc,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Center(
              child: userDetailsController.username.value == widget.owner
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isLoading
                                ? Center(
                                    child: Column(
                                      children: [
                                        LoadingAnimationWidget.beat(
                                            color: Colors.redAccent, size: 20),
                                      ],
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      handleDeleteBiz();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                            IconButton(
                              onPressed: () {
                                handleEditBiz();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: primaryTxtColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ) // Replace 'assets/admin_image.png' with the path to your admin image asset
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  handleEditBiz() {
    editBizController.updateBizDetails(
      widget.title,
      widget.business_desc,
      widget.photo,
      widget.category,
      widget.business_location,
      widget.business_id.toString(),
    );

    Navigator.of(context).pushNamed("/editbiz");
  }

  void handleDeleteBiz() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this business?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                handleDelete(); // Proceed with deletion
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> handleDelete() async {
    setState(() {
      isLoading = true;
    });
    var response = await removeBiz();
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacementNamed("/allbiz");
    } else {
      print('Failed to delete. Status code: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
      showingDialogMsg("Deletion Error", "Failed To Delete");
    }
  }

  Future<http.Response> removeBiz() async {
    final url = Uri.parse('$base_url/biz/${widget.business_id}');

    // Prepare the headers
    final headers = {'Content-Type': 'application/json'};

    // Make the delete request
    return http.delete(url, headers: headers);
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
