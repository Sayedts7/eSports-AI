


import 'package:esports/features/auth/view/forgot_password_view.dart';
import 'package:esports/features/auth/view/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/MySize.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_path.dart';
import '../../../core/constants/textStyles.dart';
import '../../../core/custom_widgets/circular_container.dart';
import '../../../core/custom_widgets/custom_button.dart';
import '../../../core/custom_widgets/custom_textfield.dart';
import '../../../core/utils.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Obx(
            ()
    {
      return Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MySize.size20),
              child: SingleChildScrollView(
                child: Form(
                  key: _authController.formKey,
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
                            'Sign in',
                            style:  AppTextStyles.heading
                        ),
                      ),
                      SizedBox(
                        height: MySize.size24,
                      ),
                      CustomTextField13(
                        keyboardType: TextInputType.emailAddress,
                        controller: _authController.loginEmailController,
                        focusNode: _authController.loginEmailFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onAction: TextInputAction.next,

                        onSubmitted: (value) {
                          print(value);
                          FocusScope.of(context).requestFocus(_authController.loginPasswordFocusNode);
                        },
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
                        controller: _authController.loginPasswordController,
                        focusNode: _authController.loginPasswordFocusNode,
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
                        onAction: TextInputAction.done,
                        // validator: (value) =>
                        //     CommonFunctions.validateTextField(value, context, 'password'),
                      )),
                      SizedBox(
                        height: MySize.size15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordView()));
                              },
                              child:  const Text('Forgot Password?',
                                  style:  AppTextStyles.label12400BTC
                              )),

                        ],
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      CustomButton8(text: 'Sign in', onPressed: (){
                        _authController.login();
                        // print('object2');
                        //used this method to keep all login functionality out of widget tree
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>  PhoneVerificationView()));
                      }),
                      SizedBox(
                        height: MySize.size15,
                      ),


                      SizedBox(
                        height: MySize.screenHeight * 0.25,
                      ),

                      RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style:  AppTextStyles.label14400BTC2,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' Sign up',
                              style: AppTextStyles.label16600P,

                              // Add a tap recognizer to handle the sign-up action
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignUpView()));
                                  // Implement the sign-up action here
                                  print('Sign up tapped');
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
    }


      ),
    );
  }
}