import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/utils/constants.dart';

import '../../base/custom_loader.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/user_controller.dart';
import '../../data/repository/user_repo.dart';
import '../../models/user_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/profile_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => User(name: '', email: '', address: ''));
    Get.lazyPut(() => UserController(userRepo: Get.find()));
    Get.lazyPut(() => UserRepo(sharedPreferences: Get.find(), user: Get.find()));
  }
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTextColor,
        centerTitle: true,
        title: BigText(
          text: "Profile", size: Dimensions.height20+4, color: Colors.white,
        ),
      ),
      body: FutureBuilder<User>(
        future: userController.getUserInfo(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CustomLoader();
          } else if(snapshot.hasError) {
            return BigText(text: 'Error ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return BigText(text: "No user data available");
          } else {
            User user = snapshot.data!;
            return Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: Dimensions.height20),
              child: Column(
                children: <Widget>[
                  AppIcons(icon: Icons.person,
                    iconcolor: Colors.white,
                    iconSize: Dimensions.height100-25,
                    backgroundColor: Colors.black54,
                    size: Dimensions.height100+50,
                  ),
                  SizedBox(height: Dimensions.height30,),
                  //profile icon
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          ProfileWidget(
                              appIcons: AppIcons(icon: Icons.person,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                backgroundColor: Colors.black54,
                                size: Dimensions.height10*5,
                              ),
                              bigText: BigText(text: user.name!,)
                          ),
                          SizedBox(height: Dimensions.height10/2,),
                          //phone
                          ProfileWidget(
                              appIcons: AppIcons(icon: Icons.phone,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                backgroundColor: kyellowColor,
                                size: Dimensions.height10*5,
                              ),
                              bigText: BigText(text: user.address!,)
                          ),
                          SizedBox(height: Dimensions.height10/2,),
                          //email
                          ProfileWidget(
                              appIcons: AppIcons(icon: Icons.email,
                                iconcolor: Colors.white,
                                iconSize: Dimensions.height10*5/2,
                                backgroundColor: kyellowColor,
                                size: Dimensions.height10*5,
                              ),
                              bigText: BigText(text: user.email!,)
                          ),
                          SizedBox(height: Dimensions.height10/2,),
                          //messages
                          GestureDetector(
                            onTap: () {
                                Get.find<AuthController>().logout();

                                Get.offAllNamed(RouteHelper.LOGIN);
                            },
                            child: ProfileWidget(
                                appIcons: AppIcons(icon: Icons.logout,
                                  iconcolor: Colors.white,
                                  iconSize: Dimensions.height10*5/2,
                                  backgroundColor: Colors.redAccent,
                                  size: Dimensions.height10*5,
                                ),
                                bigText: BigText(text: "Logout",)
                            ),
                          ),
                          SizedBox(height: Dimensions.height10/2,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}