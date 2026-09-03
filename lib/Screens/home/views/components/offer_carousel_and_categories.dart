import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'categories.dart';
import 'offers_carousel.dart';
import 'package:flutter/foundation.dart';

class OffersCarouselAndCategories extends StatelessWidget {
  const OffersCarouselAndCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // While loading use 👇
        // const OffersSkelton(),
        kIsWeb? Container(
          height: screenHeight/1.5,
          width: screenWidth,
          child: OffersCarousel(),) : OffersCarousel(),
        // const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const CategoriesSkelton(),
        const Categories(),
      ],
    );
  }
}
