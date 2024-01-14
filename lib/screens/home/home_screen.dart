import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/base/custom_loader.dart';
import 'package:shop_app/base/show_custom_snackbar.dart';
import 'package:shop_app/controller/cart_controller.dart';
import 'package:shop_app/utils/constants.dart';
import 'package:shop_app/controller/products_controller.dart';

import '../../models/Product.dart';
import '../../utils/dimensions.dart';
import '../details/details_screen.dart';
import 'components/categorries.dart';
import 'components/item_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return Stack(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/cart.svg",
                    colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    if(_cartController.totalItems > 0) {
                      //go to cart page
                    } else {
                      ShowCustomSnackBar("Please add an item to your cart");
                    }
                  },
                ),
                Positioned(
                  right: Dimensions.width10-3,
                  top: Dimensions.width10-3,
                  child: Container(
                    width: Dimensions.width15,
                    height: Dimensions.height15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _cartController.totalItems > 0?Colors.white:Colors.transparent,
                    ),
                    child: Center(
                      child: Text(_cartController.totalItems.toString(), style: TextStyle(fontSize: Dimensions.font16-6, fontWeight: FontWeight.w700, color: _cartController.totalItems>0?Colors.black54:Colors.transparent),),
                    ),
                  ),
                )
              ],
            );
          }),
          SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Products Listing",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          GetBuilder<ProductsController>(builder: (_productController) {
            _productController.getProductsList();
            List<Product> products = _productController.productsList;
            return _productController.isLoaded?Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                    product: products[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          product: products[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ):CustomLoader();
          }),
        ],
      ),
    );
  }
}
