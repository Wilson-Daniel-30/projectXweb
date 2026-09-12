import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:projectx/components/cart_button.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/entry_point.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectx/HelperFunctions.dart';
import 'package:projectx/Screens/checkout/views/OrderConfirmationScreen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/ViewModel/OrderConfirmationViewModel.dart';
import 'package:projectx/models/OrderInfo.dart';
import 'package:projectx/models/CartItemNameCountInfo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


class PaymentScreen extends StatefulWidget {
  final double totalPayableAmount;

  const PaymentScreen({Key? key, required this.totalPayableAmount}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorPay;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  var fullAddress;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      setState(() {});

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final contact = _phoneController.text.trim();
      final flat = _addressLine1Controller.text.trim();
      final street = _addressLine2Controller.text.trim();
      final city = _cityController.text.trim();
      final state = _stateController.text.trim();
      final pincode = _zipCodeController.text.trim();

      fullAddress = '$flat, $street, $city, $state - $pincode';

      HelperFunctions.showSnackBar(context, "Validating information" ,  3);

      Future.delayed(Duration(seconds: 3)).then((_){
        String responseOrderID = "ORD${HelperFunctions.generateOrderId()}";
        final cartItems = Provider.of<CartViewModel>(context, listen: false).cartItems;

        List<CartItemNameCountInfo> cartItemsInfo = [];
        cartItems.forEach((item){
          cartItemsInfo.add(CartItemNameCountInfo(name:item.product.title,count:item.quantity));
        });

        OrderInfo orderInfo = OrderInfo(userName: _nameController.text, userEmail: _emailController.text, orderNumber: responseOrderID, paymentId: "COD", amountPaid: widget.totalPayableAmount, userAddress: fullAddress, cartItems: cartItemsInfo,dateTime: DateTime.now().toUtc().toString());

        // _openCheckout();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => OrderConfirmationViewModel()..setOrderInfo(orderInfo),
              child: const OrderConfirmationScreen(),
            ),
          ),
        );
      });

      print("Name: $name");
      print("Email: $email");
      print("Contact: $contact");
      print("Address: $fullAddress");


    }
  }

  @override
  void initState() {
    super.initState();
    // if (!kIsWeb) {
    //   razorPay = Razorpay();
    //   razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    //   razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    //   razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // }
    if (kDebugMode){
      _nameController.text = "Wilson";
      _emailController.text = "danielwilson71935@gmail.con";
      _phoneController.text ="9990075695";
      _addressLine1Controller.text = "H-194";
      _addressLine2Controller.text = "";
      _cityController.text = "Noida";
      _stateController.text = "Uttar Pradesh";
      _zipCodeController.text = "201311";
    }
  }

  void _openCheckout() {
    var options = {
      // 'key': 'rzp_test_R9RC48sJja8Zf3',
      'key': 'rzp_live_R9c5nts6Z3yVn9',
      'amount': widget.totalPayableAmount*100, // Amount is in paise (5000 paise = ₹50)
      'name': 'Oliviya Occurance',
      'description': 'Order Payment',
      'prefill': {
        'contact': _phoneController.text,
        'email': _emailController.text
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      if (kIsWeb) return;
      razorPay.open(options);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      razorPay.clear();
    }
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Payment Successful!! Order Id: ${response.paymentId}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: primaryColor, // professional dark tone
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
    );
    String responseData = response.data.toString();
    String responseOrderID = "ORD${HelperFunctions.generateOrderId()}";
    String responsePaymentID = response.paymentId.toString();
    String responseSignature = response.signature.toString();
    final cartItems = Provider.of<CartViewModel>(context, listen: false).cartItems;

    List<CartItemNameCountInfo> cartItemsInfo = [];
    cartItems.forEach((item){
      cartItemsInfo.add(CartItemNameCountInfo(name:item.product.title,count:item.quantity));
    });




    OrderInfo orderInfo = OrderInfo(userName: _nameController.text, userEmail: _emailController.text, orderNumber: responseOrderID, paymentId: responsePaymentID, amountPaid: widget.totalPayableAmount, userAddress: fullAddress, cartItems: cartItemsInfo,dateTime: DateTime.now().toUtc().toString());


    _isLoading = false;
    setState(() {});



    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => OrderConfirmationViewModel()..setOrderInfo(orderInfo),
          child: const OrderConfirmationScreen(),
        ),
      ),
    );

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("response$response");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payment Failed: ${response.code} | ${response.message}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: primaryColor, // professional dark tone
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
    );
    _isLoading = false;
    setState(() {});

  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("response$response");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "External Wallet Selected: ${response.walletName}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: primaryColor, // professional dark tone
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
      ),
    );
    _isLoading = false;
    setState(() {});

  }

  Widget _buildStepLine(bool active) {
    return Expanded(

      child: Container(
        height: 2,
        color: active ? primaryColor : Colors.grey[300],
      ),
    );
  }
  Widget _buildStepCircle(int step, bool active) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: active ? primaryColor : Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: TextStyle(
            color: active ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool required = true,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label + (required ? ' *' : ''),
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primaryColor, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red[300]!, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red[500]!, width: 1.5),
          ),
        ),
        validator: validator,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(
                "Address & Payment",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

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
                return Column(
                  children: [
                    // Progress indicator
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    //   color: Colors.white,
                    //   child: Row(
                    //     children: [
                    //       // Expanded(
                    //       //   child: Row(
                    //       //     children: [
                    //       //       _buildStepCircle(1, true),
                    //       //       _buildStepLine(true),
                    //       //       _buildStepCircle(2, true),
                    //       //       _buildStepLine(false),
                    //       //       _buildStepCircle(3, false),
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //       // const SizedBox(width: 8),
                    //       // Text(
                    //       //   'Step 2 of 3',
                    //       //   style: TextStyle(
                    //       //     fontSize: 12,
                    //       //     color: Colors.grey[600],
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),

                    // Form
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: const EdgeInsets.only(left:16,right: 16,bottom: 16),
                          children: [
                            const Text(
                              'Deliver to',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Full Name
                            _buildTextFormField(
                              controller: _nameController,
                              label: 'Full Name',
                              hint: 'Oliviya Occurance',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Email
                            _buildTextFormField(
                              controller: _emailController,
                              label: 'Email Address',
                              hint: 'oliviya.occurance@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Phone
                            _buildTextFormField(
                              controller: _phoneController,
                              label: 'Phone Number',
                              hint: '(123) 456-7890',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Address Line 1
                            _buildTextFormField(
                              controller: _addressLine1Controller,
                              label: 'Address Line 1',
                              hint: '123 Main Street',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Address Line 2 (Optional)
                            _buildTextFormField(
                              controller: _addressLine2Controller,
                              label: 'Address Line 2 (Optional)',
                              hint: 'Apt, Suite, Building (optional)',
                              required: false,
                            ),
                            const SizedBox(height: 16),

                            // City and State
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // City
                                Expanded(
                                  flex: 3,
                                  child: _buildTextFormField(
                                    controller: _cityController,
                                    label: 'City',
                                    hint: 'New York',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter city';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // State
                                Expanded(
                                  flex: 2,
                                  child: _buildTextFormField(
                                    controller: _stateController,
                                    label: 'State',
                                    hint: 'NY',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter state';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // ZIP Code
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: _buildTextFormField(
                                controller: _zipCodeController,
                                label: 'ZIP Code',
                                hint: '10001',
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter ZIP code';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),

                    // Continue Button
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.1),
                    //         spreadRadius: 1,
                    //         blurRadius: 3,
                    //         offset: const Offset(0, -1),
                    //       ),
                    //     ],
                    //   ),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         if (_formKey.currentState!.validate()) {
                    //           // Process data and continue to next step
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             const SnackBar(content: Text('Processing Data')),
                    //           );
                    //         }
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.blue[600],
                    //         padding: const EdgeInsets.symmetric(vertical: 16),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //       ),
                    //       child: const Text(
                    //         'Continue',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 8),
                      Container(
                        margin: EdgeInsets.only(left: 25,right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Fee",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),
                            Row(
                              children: [
                                Text("₹${deliveryFee.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black,decoration: TextDecoration.lineThrough),),
                                SizedBox(width: 8,),
                                Text("Free Delivery",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: successColor),),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E8), // Light green background
                          borderRadius: BorderRadius.circular(defaultBorderRadious),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Percentage icon with green background
                            Image.asset('assets/icons/discountImage.png',color: successColor,width: 16,),
                            const SizedBox(width: 8),
                            // Savings text
                            Text(
                              "You'll save  \₹${mrpPrice-total}  on this order!",
                              style: TextStyle(
                                color: Color(0xFF16A34A), // Dark green text
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
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
                        title: kIsWeb ? "Cash on Delivery" : "Checkout",
                        subTitle: "Total price",
                        press: () {
                          _submitForm();
                        },
                      ),
                    ],
                  ),
                ) : Container(child: Text(""),);
              },
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.9),
              child: Center(
                child: LoadingAnimationWidget.fallingDot(
                  color: Colors.green,
                  size: 60,
                ),
              ),
            ),
        ]
    );
  }
}
