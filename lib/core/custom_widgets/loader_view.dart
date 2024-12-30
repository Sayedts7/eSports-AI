import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/controller/loader_controller.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instantiate the LoaderController
    final loaderController = Get.put(LoaderController());

    return Obx(() => (loaderController.showLoader.value)
        ? Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blue, // Replace with `Theme.of(context).primaryColor` if needed
                ),
              ),
            ),
          ),
        ],
      ),
    )
        : Container());
  }
}
