import 'package:get/get.dart';

class LoaderController extends GetxController {
  // Observable variable for the loader's visibility
  var showLoader = false.obs;

  // Method to show the loader
  void show() {
    showLoader.value = true;
  }

  // Method to hide the loader
  void hide() {
    showLoader.value = false;
  }
}
