import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esports/core/constants/MySize.dart';
import 'package:esports/core/constants/colors.dart';
import 'package:esports/core/constants/image_path.dart';
import 'package:esports/core/constants/textStyles.dart';
import 'package:esports/core/custom_widgets/custom_button.dart';
import 'package:esports/core/custom_widgets/custom_textfield.dart';
import 'package:esports/core/custom_widgets/loader_view.dart';
import 'package:esports/core/utils.dart';
import 'package:esports/features/profile/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// my_profile_view.dart
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileView extends StatelessWidget {
  MyProfileView({super.key});

  final MyProfileController controller = Get.put(MyProfileController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            title:  Text(
              'My profile',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),            ),
            centerTitle: true,
            automaticallyImplyLeading: true,
            actions: [
              Obx(
                    () => IconButton(
                  icon: Icon(
                    controller.isEditing.value ? Icons.close : Icons.edit,
                    color: blackColor,
                  ),
                  onPressed: controller.toggleEditing,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 0.5,
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(MySize.size20),
                  child: Obx(() {
                    if (controller.name?.value == null ||
                        controller.email?.value == null) {
                      return const CircularProgressIndicator();
                    }

                    nameController.text = controller.name?.value ?? '';
                    emailController.text = controller.email?.value ?? '';

                    return Column(
                      children: [
                        CustomTextField13(
                          title: 'Name',
                          readOnly: !controller.isEditing.value,
                          controller: nameController,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(MySize.size15),
                            child: SvgPicture.asset(user),
                          ),
                          hintText: 'Name',
                          fillColor: whiteColor,
                          onChanged: (value) => controller.updateName(value),
                        ),
                        SizedBox(height: MySize.size20),
                        CustomTextField13(
                          title: 'Email',
                          readOnly: true,
                          controller: emailController,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(MySize.size15),
                            child: SvgPicture.asset(user),
                          ),
                          hintText: 'Email',
                          fillColor: whiteColor,
                        ),
                        SizedBox(height: MySize.size120),
                        Obx(
                              () => Visibility(
                            visible: controller.isEditing.value,
                            child: CustomButton8(
                              text: 'Update',
                              onPressed: controller.updateUserProfile,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Obx(() => Visibility(
          visible: controller.isLoading.value,
          child: const Center(child: CircularProgressIndicator()),
        )),
      ],
    );
  }
}