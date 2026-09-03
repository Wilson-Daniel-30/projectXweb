import 'package:flutter/material.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/web/web_image.dart';

class SecondaryProductCardWeb extends StatelessWidget {
  const SecondaryProductCardWeb({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountpercent,
    this.press,
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfterDiscount;
  final int? discountpercent;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 128,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadious),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: press,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadious),
              border: Border.all(color: blackColor10),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 112,
                  height: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const ColoredBox(color: lightGreyColor),
                      WebFillNetworkImage(
                        url: image,
                        iconSize: 28,
                      ),
                      if (discountpercent != null)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: const BoxDecoration(
                              color: errorColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text(
                              "$discountpercent% off",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brandName.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 10, letterSpacing: 0.3),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 13,
                                    height: 1.25,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor,
                                  ),
                        ),
                        const Spacer(),
                        priceAfterDiscount != null
                            ? Row(
                                children: [
                                  Text(
                                    "₹${formatInr(priceAfterDiscount!)}",
                                    style: const TextStyle(
                                      color: Color(0xFF31B0D8),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      "₹${formatInr(price)}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "₹${formatInr(price)}",
                                style: const TextStyle(
                                  color: Color(0xFF31B0D8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
