import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../banner_discount_tag.dart';
import 'banner_m.dart';
import 'package:flutter/src/foundation/constants.dart';
import '../../../constants.dart';

class BannerMStyle2 extends StatelessWidget {
  const BannerMStyle2({
    super.key,
    this.image = kIsWeb?"https://raw.githubusercontent.com/Wilson-Daniel/Assignment/main/untitled%20folder/Untitled%20design%20(11).png":"https://drive.google.com/uc?export=download&id=1T38bT3xhMX-VbNvJ969DFTUuwvsgRSX-",
    required this.title,
    required this.press,
    this.subtitle,
    required this.discountParcent,
  });
  final String? image;
  final String title;
  final String? subtitle;
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
                    Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: kIsWeb?45:28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: defaultPadding / 4),
                    if (subtitle != null)
                      Text(
                        subtitle!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: kIsWeb?18:12,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: defaultPadding),
              SizedBox(
                height: 48,
                width: 48,
                child: ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/Arrow - Right.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.topCenter,
        //   child: BannerDiscountTag(percentage: discountParcent),
        // ),
      ],
    );
  }
}
