import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants.dart';
import 'product_availability_tag.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
    this.asSliver = true,
  });

  final String title, brand, description;
  final double rating;
  final int numOfReviews;
  final bool isAvailable;
  final bool asSliver;

  @override
  Widget build(BuildContext context) {

    final parts = description.split('🔖 Ideal For:');

    final String description1 = parts[0].trim();
    final String idealFor = parts.length > 1 ? '\n 🔖 Ideal For: \n${parts[1].trim()}' : "";


    //final parts = description.split('Ideal For:');

    //final String description1 = parts[0].trim();   // Text before "Ideal For"
    //final String idealFor = parts.length > 1 ? parts[1].trim() : "";
    print("idealFor $idealFor ");
    print("description1 $description1 ");

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brand.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          title,
          maxLines: 2,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            ProductAvailabilityTag(isAvailable: isAvailable),
            const Spacer(),
            SvgPicture.asset("assets/icons/Star_filled.svg"),
            const SizedBox(width: defaultPadding / 4),
            Text(
              "$rating ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text("($numOfReviews Reviews)")
          ],
        ),
        const SizedBox(height: defaultPadding),
        Text(
          "Product info",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          description1,
          style: const TextStyle(height: 1.4),
        ),
        Text(
          idealFor,
          style: const TextStyle(height: 1.4, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: defaultPadding / 2),
      ],
    );

    if (!asSliver) {
      return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: info,
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(child: info),
    );
  }
}
