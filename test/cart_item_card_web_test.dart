import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectx/web/cart_item_card_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpCard(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: size.width,
            child: CartItemCardWeb(
              image: 'https://example.com/p.png',
              brandName: 'Divinity Lane',
              title: 'Emmanuel Frame – Holy water Anointed Jesus Portrait',
              price: 1048,
              priceAfterDiscount: 629,
              discountpercent: 40,
              quantity: 1,
              onIncrement: () {},
              onDecrement: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('card stretches to the list width', (tester) async {
    await pumpCard(tester, const Size(900, 600));

    final card = tester.getRect(find.byKey(kCartItemCardWebKey));
    expect(card.width, closeTo(900, 1));
  });

  testWidgets('qty sits above the line total on the right', (tester) async {
    await pumpCard(tester, const Size(900, 600));

    expect(find.byKey(kCartItemCardWebKey), findsOneWidget);
    expect(find.text('₹629'), findsOneWidget);
    expect(find.text('₹1048'), findsOneWidget);
    expect(find.text('₹629.00'), findsOneWidget);
    expect(find.text('1 × ₹629'), findsOneWidget);
    expect(find.text('40% off'), findsOneWidget);

    final qty = tester.getRect(find.byKey(kCartItemQuantityKey));
    final total = tester.getRect(find.byKey(kCartItemLineTotalKey));
    expect(qty.bottom, lessThanOrEqualTo(total.top + 1));
    expect((qty.right - total.right).abs(), lessThan(8));

    final thumb = tester.getSize(find.byKey(kCartItemThumbnailKey));
    expect(thumb.width, 88);
    expect(thumb.height, 88);
  });

  testWidgets('narrow card keeps qty above the line total', (tester) async {
    await pumpCard(tester, const Size(390, 800));

    expect(find.byKey(kCartItemCardWebKey), findsOneWidget);
    expect(find.text('₹629'), findsOneWidget);
    expect(find.text('₹629.00'), findsOneWidget);

    final qty = tester.getRect(find.byKey(kCartItemQuantityKey));
    final total = tester.getRect(find.byKey(kCartItemLineTotalKey));
    expect(qty.bottom, lessThanOrEqualTo(total.top + 1));
  });
}
