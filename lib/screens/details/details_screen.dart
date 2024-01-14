import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/utils/constants.dart';
import 'package:shop_app/models/Product.dart';

import '../../controller/shared_preferences_helper.dart';
import 'components/add_to_cart.dart';
import 'components/cart_counter.dart';
import 'components/color_and_size.dart';
import 'components/counter_with_fav_btn.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // each product have a color
      backgroundColor: Color(0xFF989493),
      appBar: AppBar(
        backgroundColor: Color(0xFF989493),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/cart.svg"),
            onPressed: () {},
          ),
          SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Color"),
                                  Row(
                                    children: <Widget>[
                                      ColorDot(
                                        color: Color(0xFF356C95),
                                        isSelected: true,
                                      ),
                                      ColorDot(
                                        color: Color(0xFFF8C078),
                                        isSelected: true,
                                      ),
                                      ColorDot(color: Color(0xFFA29B9B), isSelected: false),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: kTextColor),
                                  children: [
                                    TextSpan(text: "Ratings"),
                                    TextSpan(
                                      text: "${widget.product.rating!.rate}/${widget.product.rating!.count}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                          child: Text(
                            widget.product.description!,
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        GestureDetector(
                          onTap: () async {
                            await SharedPreferencesHelper.addToFavorites(widget.product);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CartCounter(),
                              Container(
                                padding: EdgeInsets.all(8),
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF6464),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset("assets/icons/heart.svg"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: kDefaultPaddin / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: kDefaultPaddin),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Color(0xFF989493),
                                  ),
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/icons/add_to_cart.svg",
                                    colorFilter: ColorFilter.mode(Color(0xFF989493), BlendMode.srcIn),
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {

                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18)),
                                    backgroundColor: Color(0xFF989493),
                                  ),
                                  child: Text(
                                    "Buy  Now".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product.title!.split(' ')[0],
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          height: 50,
                          child: Text(
                            widget.product.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: kDefaultPaddin),
                        Row(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: "Price\n"),
                                  TextSpan(
                                    text: "\$${widget.product.price}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: kDefaultPaddin),
                            Container(
                              height: 150,
                              width: 150,
                              margin: EdgeInsets.only(left: 50, top: 50),
                              child: Hero(
                                tag: "${widget.product.id}",
                                child: Image.network(
                                  widget.product.image!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
