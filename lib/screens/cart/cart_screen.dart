import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/products_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../details/details_screen.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcons(icon: Icons.arrow_back_ios,
                      iconcolor: Colors.white,
                      backgroundColor: Colors.black54,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20*5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getHome());
                    },
                    child: AppIcons(icon: Icons.home_outlined,
                      iconcolor: Colors.white,
                      backgroundColor: Colors.black54,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcons(icon: Icons.shopping_cart,
                    iconcolor: Colors.white,
                    backgroundColor: Colors.black54,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              )
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    //color: Colors.red,
                    child: GetBuilder<CartController>(builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      var productsIndex = Get.find<ProductsController>()
                                          .productsList.indexOf(_cartList[index].product!);
                                      if(productsIndex >= 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              product: _cartList[index].product!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      height: Dimensions.height20*5,
                                      width: Dimensions.width20*5,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(cartController.getItems[index].img!),
                                              fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10,),
                                  Expanded(
                                      child: Container(
                                        height: Dimensions.height20*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            BigText(text: cartController.getItems[index].title!, color: Colors.black54,),
                                            SmallText(text: "${cartController.getItems[index].title!.split(' ')[0]}"),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: "\$${cartController.getItems[index].price!.toString()}", color: Colors.redAccent,),
                                                Container(
                                                  padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20)
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(_cartList[index].product!, -1);
                                                            print("being tapped");
                                                          },
                                                          child: Icon(Icons.remove, color: const Color(0xFFa9a29f),)),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      BigText(text: _cartList[index].quantity.toString()), //popularProduct.itemsInCart.toString()),
                                                      SizedBox(width: Dimensions.width10/2,),
                                                      GestureDetector(
                                                          onTap: (){
                                                            cartController.addItem(_cartList[index].product!, 1);
                                                            print("being tapped");
                                                          },
                                                          child: Icon(Icons.add, color: const Color(0xFFa9a29f),))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  )
                                ],
                              ),
                            );
                          });
                    },)
                )
            ):const NoDataPage(text: "Your Cart is Empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
            height: Dimensions.bottomnavbarheight110,
            padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20*2), topRight: Radius.circular(Dimensions.radius20*2)),
                color: const Color(0xFFf7f6f4)
            ),
            child: cartController.getItems.isNotEmpty?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "\$" + cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width10/2,),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  child: BigText(text: "Check Out", color: Colors.white,),
                )
              ],
            ):Container()
        );
      },),
    );
  }
}

