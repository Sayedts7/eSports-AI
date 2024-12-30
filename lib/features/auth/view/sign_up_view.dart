


import 'package:esports/features/auth/view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common_function.dart';
import '../../../core/constants/MySize.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_path.dart';
import '../../../core/constants/textStyles.dart';
import '../../../core/custom_widgets/circular_container.dart';
import '../../../core/custom_widgets/custom_button.dart';
import '../../../core/custom_widgets/custom_textfield.dart';
import '../../../core/utils.dart';
import '../controller/auth_controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      // appBar: AppBar(title: Text('Sign Up')),
      body: Obx(
            (){
              return Stack(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _authController.signupFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MySize.size20,
                              ),
                              SvgPicture.asset(logoSec, height: 80,),
                              SizedBox(
                                height: MySize.size60,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'Sign Up',
                                    style:  AppTextStyles.heading
                                ),
                              ),
                              SizedBox(
                                height: MySize.size24,
                              ),
                              CustomTextField13(
                                keyboardType: TextInputType.text,
                                controller: _authController.nameController,
                                focusNode: _authController.nameFocusNode,
                                validator: (value) => CommonFunctions.validateTextField(
                                    value, context, 'name'),
                                onSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_authController.emailFocusNode);
                                },
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset(user),
                                ),
                                hintText: 'Enter player name',
                                fillColor: backgroundColor,
                                // validator: (value) => CommonFunctions.validateTextField(
                                //     value, context, 'email'),
                                onAction: TextInputAction.next,

                              ),

                              SizedBox(
                                height: MySize.size20,
                              ),
                              CustomTextField13(
                                keyboardType: TextInputType.emailAddress,
                                controller: _authController.emailController,
                                focusNode: _authController.emailFocusNode,
                                validator: (value) => CommonFunctions.validateTextField(
                                    value, context, 'email'),
                                // onSubmitted: (value) {
                                //   print(value+'11111111111111111111111111111');
                                //   FocusScope.of(context).requestFocus(_authController.passwordFocusNode);
                                // },
                                onAction: TextInputAction.next,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SvgPicture.asset(email),
                                ),
                                hintText: 'Enter Your Email',
                                fillColor: backgroundColor,
                                // validator: (value) => CommonFunctions.validateTextField(
                                //     value, context, 'email'),
                              ),

                              SizedBox(
                                height: MySize.size20,
                              ),
                              Obx(() => CustomTextField13(
                                controller: _authController.passwordController,
                                focusNode: _authController.passwordFocusNode,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(MySize.size15),
                                  child: SvgPicture.asset(password),
                                ),
                                hintText: 'Password',
                                obscureText: _authController.isObscure.value,
                                fillColor: backgroundColor,
                                sufixIcon: Padding(
                                  padding: EdgeInsets.all(MySize.size15),
                                  child: GestureDetector(
                                    onTap: () {
                                      _authController.toggleObscure();
                                    },
                                    child: SvgPicture.asset(obscure),
                                  ),
                                ),
                                validator: (value) =>
                                    CommonFunctions.validateTextField(value, context, 'password'),
                                onSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(_authController.confirmPasswordFocusNode);
                                },
                                onAction: TextInputAction.next,

                              )),

                              SizedBox(
                                height: MySize.size20,
                              ),
                              Obx(() => CustomTextField13(
                                controller: _authController.confirmPasswordController,
                                focusNode: _authController.confirmPasswordFocusNode,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(MySize.size15),
                                  child: SvgPicture.asset(password),
                                ),
                                hintText: 'Confirm Password',
                                obscureText: _authController.isObscure.value,
                                fillColor: backgroundColor,
                                sufixIcon: Padding(
                                  padding: EdgeInsets.all(MySize.size15),
                                  child: GestureDetector(
                                    onTap: () {
                                      _authController.toggleObscure();
                                    },
                                    child: SvgPicture.asset(obscure),
                                  ),
                                ),
                                validator: (value) =>
                                    CommonFunctions.validateTextField(value, context, 'password'),
                                onSubmitted: (value) {
                                  FocusScope.of(context).unfocus();
                                },
                                onAction: TextInputAction.done,
                              )),

                              SizedBox(
                                height: MySize.size20,
                              ),
                              CustomButton8(text: 'Sign Up', onPressed: (){
                                _authController.signup();
                                print('object');
                                //used this method to keep all login functionality out of widget tree
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>  PhoneVerificationView()));
                              }),


                              SizedBox(
                                height: MySize.screenHeight * 0.15,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Already have an account? ',
                                  style:  AppTextStyles.label14400BTC2,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Sign In',
                                      style: AppTextStyles.label16600P,

                                      // Add a tap recognizer to handle the sign-up action
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.back();
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpView()));
                                          // Implement the sign-up action here
                                          print('Sign in tapped');
                                        },
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _authController.isLoading.value ? Center(child: CircularProgressIndicator()): Container(),

                ],
              );


            },
      ),
    );
  }
}