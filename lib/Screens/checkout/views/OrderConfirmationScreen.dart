import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/entry_point.dart';
import 'package:projectx/ViewModel/OrderConfirmationViewModel.dart';
import 'package:provider/provider.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:share_plus/share_plus.dart';


class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OrderConfirmationViewModel>(context);
    final info = viewModel.orderInfo;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<OrderConfirmationViewModel>(
        builder : (context,info,_){
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () async {
                    Provider.of<CartViewModel>(context,listen:false).clearCart();
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => EntryPoint(initialIndex: 0,)));
                  },
                ),
                title: const Text('Order', style: TextStyle(color: Colors.black)),
                actions: [
                  // IconButton(
                  //   icon: const Icon(Icons.ios_share_outlined, color: Colors.black),
                  //   onPressed: () {
                  //     // final buffer = StringBuffer();
                  //     //
                  //     // buffer.writeln("Order Summary");
                  //     // buffer.writeln("-------------------------");
                  //     // buffer.writeln("Order Number : ${info.orderInfo.orderNumber}");
                  //     // buffer.writeln("Payment ID   : ${info.orderInfo.paymentId}");
                  //     // buffer.writeln("Items:");
                  //     // info.orderInfo.cartItems.forEach((val) {
                  //     //   buffer.writeln("  • ${val.name} x ${val.count}");
                  //     // });
                  //     // buffer.writeln("Amount Paid  : ₹${info.orderInfo.amountPaid}");
                  //     // buffer.writeln("Customer     : ${info.orderInfo.userName}");
                  //     // buffer.writeln("Address      : ${info.orderInfo.userAddress}");
                  //     // buffer.writeln("Email        : ${info.orderInfo.userEmail}");
                  //     //
                  //     // final orderDetails = buffer.toString();
                  //     // SharePlus.instance.share(
                  //     //     ShareParams(text: orderDetails)
                  //     // );
                  //   },
                  // ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(defaultPadding * 2),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height:0),
                    Center(
                      child: Image.asset(
                        'assets/Illustration/Success_lightTheme.png',
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Thanks for your order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          const TextSpan(text: "You’ll receive an email at "),
                          TextSpan(
                            text: info.orderInfo.userEmail,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          const TextSpan(
                              text: " once your order is confirmed."),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order detail',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text(info.orderInfo.orderNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Amount paid',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                              Text('\₹${info.orderInfo.amountPaid}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: successColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 30),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 55,
                    //   child: ElevatedButton.icon(
                    //     icon: const Icon(Icons.title),
                    //     onPressed: () {
                    //       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>EntryPoint(initialIndex: 0,)));
                    //
                    //     },
                    //     label: const Text(
                    //       'Continue Shopping',
                    //       style: TextStyle(
                    //           fontSize: 16, fontWeight: FontWeight.w500),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: primaryColor,
                    //       foregroundColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(defaultBorderRadious),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 30),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
