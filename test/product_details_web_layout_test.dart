import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/web/product_details_web.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final product = ProductModel(
    image: 'https://example.com/p.png',
    brandName: 'Oliviya',
    title: 'Test Frame',
    price: 999,
    productInfo: 'A sturdy frame.',
    imageList: const ['https://example.com/p.png'],
    productRating: ProductRating(
      rating: 4.5,
      numOfReviews: 10,
      numOfFiveStar: 5,
      numOfFourStar: 3,
      numOfThreeStar: 1,
      numOfTwoStar: 1,
      numOfOneStar: 0,
    ),
  );

  Future<void> pumpAtSize(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductViewModel()),
          ChangeNotifierProvider(create: (_) => FlashSaleViewModel()),
        ],
        child: MaterialApp(
          home: ProductDetailsScreenWeb(productModel: product),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('narrow screen keeps stacked product details', (tester) async {
    // 600 is still below the 800 breakpoint; 390 overflows ProductInfo's
    // rating row (pre-existing) and can skip later slivers in tests.
    await pumpAtSize(tester, const Size(600, 3000));

    expect(find.byKey(kProductDetailsStackedKey), findsOneWidget);
    expect(find.byKey(kProductDetailsWideRowKey), findsNothing);
    expect(find.text('You may also like'), findsOneWidget);
  });

  testWidgets('wide screen puts image and details side by side', (tester) async {
    await pumpAtSize(tester, const Size(1200, 800));

    expect(find.byKey(kProductDetailsWideRowKey), findsOneWidget);
    expect(find.byKey(kProductDetailsStackedKey), findsNothing);

    final row = tester.widget<Row>(find.byKey(kProductDetailsWideRowKey));
    expect(row.crossAxisAlignment, CrossAxisAlignment.start);
    expect(find.text('You may also like'), findsOneWidget);

    final rowOffset = tester.getTopLeft(find.byKey(kProductDetailsWideRowKey));
    final likeOffset = tester.getTopLeft(find.text('You may also like'));
    expect(likeOffset.dy, greaterThan(rowOffset.dy));
  });
}
