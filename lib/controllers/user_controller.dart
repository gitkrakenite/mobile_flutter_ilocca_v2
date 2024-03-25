import 'package:get/get.dart';

//we need the index and function to update
class UserDetailsController extends GetxController {
  var username = "".obs; //variable to track username
  var phone = "".obs; //variable to track phone
  var userId = "".obs; //variable to track user id

  //methd to update
  updateUserDetails(newUsername, newPhone, newUserId) {
    username.value = newUsername;
    phone.value = newPhone;
    userId.value = newUserId;
  }
}
