import 'package:flutter/material.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/web/web_image.dart';

class ProductCardWeb extends StatelessWidget {
  const ProductCardWeb({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountpercent,
    required this.press,
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfterDiscount;
  final int? discountpercent;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final fillGrid = constraints.maxWidth.isFinite &&
            constraints.maxHeight.isFinite &&
            constraints.maxWidth >= 150 &&
            constraints.maxHeight >= 220;

        final width = fillGrid
            ? constraints.maxWidth
            : constraints.maxWidth.isFinite && constraints.maxWidth < 280
                ? constraints.maxWidth
                : 140.0;

        return SizedBox(
          width: width,
          height: fillGrid ? constraints.maxHeight : null,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      fillGrid ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    fillGrid
                        ? Expanded(child: _image())
                        : SizedBox(
                            height: 168,
                            width: double.infinity,
                            child: _image(),
                          ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
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
                                .copyWith(
                                  fontSize: 10,
                                  letterSpacing: 0.3,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 13,
                                  height: 1.25,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _price(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _image() {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: lightGreyColor),
        WebFillNetworkImage(url: image),
        if (discountpercent != null)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 3,
              ),
              decoration: const BoxDecoration(
                color: errorColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
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
    );
  }

  Widget _price(BuildContext context) {
    if (priceAfterDiscount != null) {
      return Row(
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
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 11,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      );
    }
    return Text(
      "₹${formatInr(price)}",
      style: const TextStyle(
        color: Color(0xFF31B0D8),
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }
}
