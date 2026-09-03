import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/entry_point.dart';

import '../../../constants.dart';
import 'package:projectx/Screens/checkout/views/cart_screen.dart';

class AddedToCartMessageScreen extends StatelessWidget {
  double finalPrice;
   AddedToCartMessageScreen({super.key,this.finalPrice=0.0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                    ? "assets/Illustration/success.png"
                    : "assets/Illustration/success_dark.png",
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const Spacer(flex: 2),
              Text(
                "Added to cart",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: defaultPadding / 2),
              const Text(
                "Click the checkout button to complete the purchase process.",
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => EntryPoint()),
                  // );
                },
                style: kIsWeb
                    ? OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 68),
                      )
                    : null,
                child: const Text("Continue shopping"),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => EntryPoint(initialIndex: 1)),
                  );
                },
                style: kIsWeb
                    ? ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 68),
                      )
                    : null,
                child: const Text("Checkout"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
