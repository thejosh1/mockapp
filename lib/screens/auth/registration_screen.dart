import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';
import '../../models/sign_up_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _addressController = TextEditingController();

    _registration(AuthController authController) {
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String address = _addressController.text.trim();

      if(name.isEmpty) {
        ShowCustomSnackBar("Type in Your name", title: "Name");
      } else if(email.isEmpty) {
        ShowCustomSnackBar("Type in your email", title: "Email");
      } else if(!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Your email is not in the correct format", title: "Invalid email");
      } else if(password.length < 6) {
        ShowCustomSnackBar("Password is too short", title: "Invalid Password");
      } else if(address.isEmpty) {
        ShowCustomSnackBar("Type in your phonenumber", title: "Phonenumber");
      } else {

        SignUpModel signUpModel = SignUpModel(
          name: name,
          email: email,
          address: address,
          password: password,);
        authController.registration(signUpModel).then((status) {
          if(status) {
            Get.offNamed(RouteHelper.HOME);
          } else {
            ShowCustomSnackBar("for some reason we couldn't register you", title: "Error");
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authcontroller) {
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
                      backgroundImage: const AssetImage("assets/images/bag_2.png"),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                //name
                AppTextField(textEditingController: _nameController, hintText: "Name", iconData: Icons.person, color: kyellowColor),
                SizedBox(height: Dimensions.height20,),
                //email
                AppTextField(textEditingController: _emailController, hintText: "Email", iconData: Icons.email, color: kyellowColor),
                SizedBox(height: Dimensions.height20,),
                //password
                AppTextField(textEditingController: _passwordController, hintText: "password", iconData: Icons.password_sharp, color: kyellowColor, isObscure: true,),
                SizedBox(height: Dimensions.height20,),
                //phone number
                AppTextField(textEditingController: _addressController, hintText: "Address", iconData: Icons.map, color: kyellowColor),
                SizedBox(height: Dimensions.height20,),

                //sign up
                GestureDetector(
                  onTap: () {
                    _registration(_authcontroller);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: Colors.black
                    ),
                    child: Center(child: BigText(text: "Sign Up", size: Dimensions.font20+Dimensions.font20/2, color: Colors.white,)),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                //tagline
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const LoginPage(), transition: Transition.fade),
                        text: "Have an account already",
                        style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20)
                    )
                ),
              ],
            ),
          );
        })
    );


  }
}