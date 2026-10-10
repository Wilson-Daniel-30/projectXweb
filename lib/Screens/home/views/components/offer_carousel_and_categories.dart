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
    final size = MediaQuery.sizeOf(context);
    final isWideWeb = kIsWeb && size.width >= kWebWideBreakpoint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Desktop web keeps a tall hero. Phone web uses the same
        // aspect-ratio carousel as the Android / iOS app.
        isWideWeb
            ? SizedBox(
                key: kOffersCarouselWideKey,
                height: size.height / 1.5,
                width: size.width,
                child: const OffersCarousel(),
              )
            : const OffersCarousel(key: kOffersCarouselPhoneKey),
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
