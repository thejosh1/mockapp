import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/screens/auth/registration_screen.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    _login(AuthController authController) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      if(username.isEmpty) {
        ShowCustomSnackBar("Type in Your username", title: "Name");
      } else if(password.length < 6) {
        ShowCustomSnackBar("Password is too short", title: "Invalid Password");
      } else {
        authController.login(username, password).then((status) {
          if(status == true) {
            Get.toNamed(RouteHelper.HOME);
          } else {
            print('iam ere');
            ShowCustomSnackBar("Your login credentials could not be found", title: "Error");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return SingleChildScrollView(
          physics: const  BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    radius: Dimensions.height100-20,
                    backgroundImage: const AssetImage("assets/images/bag_3.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20, bottom: Dimensions.height20),
                child: Column(
                  children: [
                    Text("Hello", style: TextStyle(fontSize: Dimensions.font20*3 + Dimensions.font20/2, fontWeight: FontWeight.bold),),
                    Text("Sign in to your account", style: TextStyle(fontSize: Dimensions.font20, color: Colors.grey[500]))
                  ],
                ),
              ),
              //email
              AppTextField(textEditingController: _usernameController, hintText: "User Name", iconData: Icons.person, color: kyellowColor),
              SizedBox(height: Dimensions.height20,),
              //password
              AppTextField(textEditingController: _passwordController, hintText: "password", iconData: Icons.password_sharp, color: kyellowColor, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Sign in to your account",
                          style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20)
                      )
                  ),
                  SizedBox(width: Dimensions.width10,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.10,),
              //login
              GestureDetector(
                onTap: () {
                  _login(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: Colors.black
                  ),
                  child: Center(child: BigText(text: "Login", size: Dimensions.font20+Dimensions.font20/2, color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.010,),
              //sign up with
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account? ",
                      style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(color: Colors.black54, fontSize: Dimensions.font16, fontWeight: FontWeight.bold)
                        )
                      ]
                  )
              ),
            ],
          ),
        );
      }),
    );
  }
}
