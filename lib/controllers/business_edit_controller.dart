import 'package:get/get.dart';

//we need the index and function to update
class BusinessEditController extends GetxController {
  var title = "".obs; //variable to track username
  var business_desc = "".obs; //variable to track phone
  var photo = "".obs; //variable to track user id
  var category = "".obs; //variable to track user id
  var business_location = "".obs; //variable to track user id
  var business_id = "".obs; //variable to track user id

  //methd to update
  updateBizDetails(
      newTitle, newDesc, newPhoto, newCategory, newLocation, newId) {
    title.value = newTitle;
    business_desc.value = newDesc;
    photo.value = newPhoto;
    category.value = newCategory;
    business_location.value = newLocation;
    business_id.value = newId;
  }
}
