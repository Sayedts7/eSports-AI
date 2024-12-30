
import 'package:esports/core/common_function.dart';
import 'package:esports/core/constants/MySize.dart';
import 'package:esports/core/constants/colors.dart';
import 'package:esports/core/constants/image_path.dart';
import 'package:esports/core/constants/textStyles.dart';
import 'package:esports/core/custom_widgets/custom_button.dart';
import 'package:esports/core/custom_widgets/custom_textfield.dart';
import 'package:esports/features/auth/controller/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MySize().init(context);

      return Obx((){
        return Stack(
          children: [
            Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text('Forgot Password'),
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.all(MySize.size20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MySize.size150,
                        ),
                        Text('Forgot Password',    style:  AppTextStyles.heading,),
                        SizedBox(
                          height: MySize.size10,
                        ),
                        Text('To reset your password, provide your account\'s email, and we\'ll send a reset link.',
                          style: AppTextStyles.label12500BTC,),
                        SizedBox(
                          height: MySize.size20,
                        ),
                        CustomTextField13(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          prefixIcon: Padding(
                            padding:  EdgeInsets.all(MySize.size15),
                            child: SvgPicture.asset(email),
                          ),
                          validator: (value) {
                            return CommonFunctions.validateTextField(value,context,'email');
                          },
                          hintText: 'Enter Your Email',
                          fillColor: backgroundColor,
                        ),
                        SizedBox(
                          height: MySize.size40,
                        ),

                        CustomButton8(text: 'Submit', onPressed: (){
                          _authController.forgotPassword();
                        }),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            _authController.isLoading.value ? Center(child: CircularProgressIndicator()): Container(),

          ],
        );
      });

  }

}
