import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:provider/provider.dart';
import 'package:projectx/Components/network_image_with_loader.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/Components/product/secondary_product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:projectx/Components/cart_button.dart';
import 'package:projectx/Components/custom_modal_bottom_sheet.dart';
import 'package:projectx/Screens/product/views/added_to_cart_message_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectx/Screens/product/views/components/ProductQusntity2.dart';
import 'package:projectx/Screens/product/views/components/unit_price.dart';
import 'package:projectx/HelperFunctions.dart';
import 'package:projectx/web/cart_item_card_web.dart';

import '../../payment/PaymentScreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Cart")),
      body: Consumer<CartViewModel>(
        builder: (context, cart, _) {
          if (cart.cartItems.isEmpty) {
            return  Center(child: Container(child: Image.asset('assets/Illustration/Illustration-1.png',scale: 2,),));
          }
          final subtotal = cart.totalPrice;
          final deliveryFee = 50.0; // Example fixed delivery cost
          final tax = subtotal * 0.18; // Example 18% tax

          final total = subtotal + deliveryFee + tax;
          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // Find demoPopularProducts on models/ProductModel.dart
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  bottom: defaultPadding/2,
                  top: index == 0
                      ? defaultPadding
                      : 0,
                ),
                child: kIsWeb
                    ? CartItemCardWeb(
                        image: cart.cartItems[index].product.image,
                        brandName: cart.cartItems[index].product.brandName,
                        title: cart.cartItems[index].product.title,
                        price: cart.cartItems[index].product.price,
                        priceAfterDiscount: cart.cartItems[index].product.priceAfterDiscount,
                        discountpercent: cart.cartItems[index].product.discountpercent,
                        quantity: cart.cartItems[index].quantity,
                        onIncrement: () {
                          cart.increaseQuantity(cart.cartItems[index].product);
                        },
                        onDecrement: () {
                          cart.decreaseQuantity(cart.cartItems[index].product);
                        },
                      )
                    : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SecondaryProductCard(
                    image: cart.cartItems[index].product.image,
                    brandName: cart.cartItems[index].product.brandName,
                    title: cart.cartItems[index].product.title,
                    price: cart.cartItems[index].product.price,
                    priceAfterDiscount: cart.cartItems[index].product.priceAfterDiscount,
                    discountpercent: cart.cartItems[index].product.discountpercent,
                    press: () {
                      // Navigate to product details
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        child: ProductQuantity2(
                          numOfItem: cart.cartItems[index].quantity,
                          onIncrement: () {
                            cart.increaseQuantity(cart.cartItems[index].product);
                          },
                          onDecrement: () => cart.decreaseQuantity(cart.cartItems[index].product),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(CupertinoIcons.minus_circled, color: Color(0xFFEA5B5B),size: 20,),
                      //       onPressed: () {
                      //         Provider.of<CartViewModel>(context,listen: false).decreaseQuantity(cart.cartItems[index].product);
                      //       },
                      //     ),
                      //     Text(
                      //       cart.cartItems[index].quantity.toString(),
                      //       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(Icons.add_circle_outline, color: Colors.green,size: 20),
                      //       onPressed: () {
                      //         // cart.increaseQuantity(cart.cartItems[index]);
                      //         Provider.of<CartViewModel>(context,listen: false).addToCart(cart.cartItems[index].product, cart.cartItems[index].quantity);
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // Delete button
                      SizedBox(
                        child: Center(
                          child: Row(
                            children: [
                              Text('${cart.cartItems[index].quantity} * ${(cart.cartItems[index].product.priceAfterDiscount??cart.cartItems[index].product.price)} =',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),),
                              Text(' ₹${(
                                  (cart.cartItems[index].product.priceAfterDiscount??cart.cartItems[index].product.price)
                                      * cart.cartItems[index].quantity
                              ).toStringAsFixed(2)}',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),),
                            ],
                          )
                          // Text(
                          //   numOfItem.toString(),
                          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                          // ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text('${cart.cartItems[index].quantity} * ${(cart.cartItems[index].product.priceAfterDiscount??cart.cartItems[index].product.price)} =',                             style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      //         ),
                      //     Text(' ₹${(
                      //         (cart.cartItems[index].product.priceAfterDiscount??cart.cartItems[index].product.price)
                      //         * cart.cartItems[index].quantity
                      //     ).toStringAsFixed(2)}   ',
                      //       style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      //   ],
                      // )

                    ],
                  ),

                ],
              ),

              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<CartViewModel>(
        builder: (context, cart, _) {
          final mrpPrice = cart.mRP;
          final subtotal = cart.totalPrice;
          final deliveryFee = 100.0; // Example fixed delivery cost
          final tax = subtotal * 0.18; // Example 18% tax

          final total = subtotal;

          return cart.cartItems.isNotEmpty? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, -1),
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 15),


                Container(
                  margin: EdgeInsets.only(left: 25,right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                      Row(
                        children: [
                          Text("₹${mrpPrice}",style: TextStyle(fontSize: 12,color: Colors.black,decoration: TextDecoration.lineThrough,),),
                          SizedBox(width: 8,),
                          Text("₹${subtotal.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                        ],
                      )

                    ],
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  margin: EdgeInsets.only(left: 25,right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                      Row(
                        children: [
                          Text("₹${deliveryFee.toStringAsFixed(2)}",style: TextStyle(fontSize: 12,color: Colors.black,decoration: TextDecoration.lineThrough),),
                          SizedBox(width: 8,),
                          Text("Free Delivery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: successColor),),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E8), // Light green background
                    borderRadius: BorderRadius.circular(defaultBorderRadious),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.asset('assets/icons/discountImage.png',color: successColor,width: 16,),
                      SizedBox(width: 6,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),

                          children: [
                            const TextSpan(text: "You'll save  ",style: TextStyle(color: successColor)),
                            TextSpan(
                              text: "\₹${mrpPrice-total}" ,
                              style: TextStyle(
                                  color: successColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const TextSpan(
                                text: "  on this order!",style: TextStyle(color: successColor)),
                          ],
                        ),
                      ),
                    ],
                  ),


                ),

                // Container(
                //   margin: EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Text("You are saving ₹${mrpPrice-total} on this order",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Color(0xFF31B0D8)),),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 5),
                // Container(
                //   margin: EdgeInsets.only(left: 20,right: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text("Tax (18%)"),
                //       Text("₹${tax.toStringAsFixed(2)}"),
                //     ],
                //   ),
                // ),
                // Divider(height: 20, thickness: 1),
                // Container(
                //   margin: EdgeInsets.only(left: 25,right: 25),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Total",
                //         style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.black),
                //       ),
                //       Text(
                //         "₹${total.toStringAsFixed(2)}",
                //         style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),

                // SizedBox(height: 5),
                CartButton(
                  price: total,
                  title: "Checkout",
                  subTitle: "Total price",
                  press: () {
                    // HelperFunctions.showSnackBar(context, "We\’re currently performing maintenance on our UPI service. In the meantime, feel free to place your order by emailing us at oliviya.occurance@gmail.com. We’ll be happy to assist you!", 10);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(totalPayableAmount: total,)));

                  },
                ),
              ],
            ),
          ) : Container(child: Text(""),);
        },
      ),
    );
  }
}