import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/components/ProductQusntity2.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/web/web_image.dart';

const Key kCartItemCardWebKey = Key('cartItemCardWeb');
const Key kCartItemPriceRowKey = Key('cartItemPriceRow');
const Key kCartItemUnitPriceKey = Key('cartItemUnitPrice');
const Key kCartItemLineTotalKey = Key('cartItemLineTotal');
const Key kCartItemQuantityKey = Key('cartItemQuantity');
const Key kCartItemThumbnailKey = Key('cartItemThumbnail');

class CartItemCardWeb extends StatelessWidget {
  const CartItemCardWeb({
    super.key,
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountpercent,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.press,
  });

  final String image, brandName, title;
  final double price;
  final double? priceAfterDiscount;
  final int? discountpercent;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback? press;

  double get _unit => priceAfterDiscount ?? price;
  double get _lineTotal => _unit * quantity;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: kCartItemCardWebKey,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Thumbnail(
                  image: image,
                  discountpercent: discountpercent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brandName.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 11,
                              letterSpacing: 0.4,
                              color: blackColor60,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      _unitPrice(context),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  key: kCartItemPriceRowKey,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    KeyedSubtree(
                      key: kCartItemQuantityKey,
                      child: ProductQuantity2(
                        numOfItem: quantity,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _lineTotalAmount(),
                    const SizedBox(height: 2),
                    Text(
                      '$quantity × ₹${formatInr(_unit)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: blackColor60,
                        fontSize: 11,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _unitPrice(BuildContext context) {
    if (priceAfterDiscount != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '₹${formatInr(priceAfterDiscount!)}',
            key: kCartItemUnitPriceKey,
            style: const TextStyle(
              color: Color(0xFF31B0D8),
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.2,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '₹${formatInr(price)}',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 12,
              height: 1.2,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    }
    return Text(
      '₹${formatInr(price)}',
      key: kCartItemUnitPriceKey,
      style: const TextStyle(
        color: Color(0xFF31B0D8),
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 1.2,
      ),
    );
  }

  Widget _lineTotalAmount() {
    return Text(
      '₹${_lineTotal.toStringAsFixed(2)}',
      key: kCartItemLineTotalKey,
      textAlign: TextAlign.right,
      style: const TextStyle(
        color: blackColor,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 1.2,
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.image,
    this.discountpercent,
  });

  final String image;
  final int? discountpercent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: kCartItemThumbnailKey,
      width: 88,
      height: 88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(defaultBorderRadious),
            child: WebFillNetworkImage(
              url: image,
              iconSize: 24,
              fit: BoxFit.cover,
            ),
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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  '$discountpercent% off',
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
    );
  }
}
