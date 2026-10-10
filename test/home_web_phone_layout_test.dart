import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectx/Screens/home/views/components/offer_carousel_and_categories.dart';
import 'package:projectx/Screens/home/views/components/offers_carousel.dart';
import 'package:projectx/constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpAtSize(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: OffersCarouselAndCategories()),
      ),
    );
    await tester.pump();
    addTearDown(() async {
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets('phone-sized home hero uses the native 1.87 aspect ratio',
      (tester) async {
    await pumpAtSize(tester, const Size(390, 844));

    expect(find.byKey(kOffersCarouselPhoneKey), findsOneWidget);
    expect(find.byKey(kOffersCarouselWideKey), findsNothing);

    final heroSize = tester.getSize(find.byKey(kOffersCarouselPhoneKey));
    expect(heroSize.width, 390);
    expect(heroSize.height, closeTo(390 / 1.87, 0.5));
    expect(heroSize.height, lessThan(844 / 1.5));
  });

  testWidgets('wide home layout still has a tall desktop hero', (tester) async {
    await pumpAtSize(tester, const Size(1200, 800));

    // Widget tests run with kIsWeb == false, so the desktop-only height
    // wrapper is not used. The carousel itself must still size by aspect
    // ratio instead of swallowing most of the viewport.
    final carousel = tester.widget<AspectRatio>(
      find.descendant(
        of: find.byType(OffersCarousel),
        matching: find.byType(AspectRatio),
      ).first,
    );
    expect(carousel.aspectRatio, 1.87);
    expect(kWebWideBreakpoint, 800);
  });
}
