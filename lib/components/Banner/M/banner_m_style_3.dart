import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'banner_m.dart';

import '../../../constants.dart';
import 'package:flutter/src/foundation/constants.dart';


class BannerMStyle3 extends StatelessWidget {
  const BannerMStyle3({
    super.key,
    this.image = kIsWeb?"https://raw.githubusercontent.com/Wilson-Daniel/Assignment/main/untitled%20folder/Untitled%20design%20(12).png":"https://drive.google.com/uc?export=download&id=1nQ9P1MOvCpYokuhI3ncDLsy9uzi7dBwO",
    required this.title,
    required this.press,
    required this.discountParcent,
  });
  final String? image;
  final String title;
  final int discountParcent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return BannerM(
      image: image!,
      press: press,
      children: [
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding / 8),
                      color: Colors.white70,
                      child: Text(
                        "Infused with Devotion",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: kIsWeb?18:12,
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: kIsWeb?48:28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              // SizedBox(
              //   height: 48,
              //   width: 48,
              //   child: ElevatedButton(
              //     onPressed: press,
              //     style: ElevatedButton.styleFrom(
              //       shape: const CircleBorder(),
              //       backgroundColor: Colors.white,
              //     ),
              //     child: SvgPicture.asset(
              //       "assets/icons/Arrow - Right.svg",
              //       colorFilter:
              //           const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
