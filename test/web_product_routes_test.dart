import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectx/web/web_product_deep_link.dart';
import 'package:projectx/web/web_product_navigation.dart';
import 'package:projectx/web/web_routes.dart';

void main() {
  group('productSlugFromTitle', () {
    test('lowercases, hyphenates, and strips punctuation', () {
      expect(
        productSlugFromTitle("The Shepherd's Blessing"),
        'the-shepherds-blessing',
      );
    });

    test('collapses extra spaces and hyphens', () {
      expect(
        productSlugFromTitle('  Holy   Water -- Frame  '),
        'holy-water-frame',
      );
    });
  });

  group('productSlugFromPath', () {
    test('parses /product/<slug>', () {
      expect(
        productSlugFromPath('/product/the-shepherds-blessing'),
        'the-shepherds-blessing',
      );
    });

    test('ignores query strings and hashes', () {
      expect(
        productSlugFromPath('/product/holy-water?ref=share'),
        'holy-water',
      );
      expect(
        productSlugFromPath('/#/product/holy-water'),
        'holy-water',
      );
    });

    test('returns null for shop and unknown paths', () {
      expect(productSlugFromPath('/'), isNull);
      expect(productSlugFromPath('/cart'), isNull);
      expect(isProductPath('/product/abc'), isTrue);
      expect(isProductPath('/'), isFalse);
    });
  });

  test('productPathFromTitle builds a shareable path', () {
    expect(
      productPathFromTitle("The Shepherd's Blessing"),
      '/product/the-shepherds-blessing',
    );
  });

  testWidgets('unknown product slug shows not-found and a shop button',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WebProductNotFoundScreen(slug: 'missing-product'),
      ),
    );

    expect(find.text('Product not found'), findsOneWidget);
    expect(find.text('Back to shop'), findsOneWidget);
    expect(find.textContaining('missing-product'), findsOneWidget);
    expect(find.byTooltip('Back to shop'), findsOneWidget);
  });

  testWidgets('back goes to shop when the product page is the only route',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateInitialRoutes: (_) => [
          MaterialPageRoute(
            settings: const RouteSettings(name: '/product/x'),
            builder: (context) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Back to shop',
                  onPressed: () => navigateBackToShop(context),
                ),
              ),
              body: const Text('Product'),
            ),
          ),
        ],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => const Scaffold(body: Text('Shop home')),
          );
        },
      ),
    );

    expect(find.text('Product'), findsOneWidget);
    await tester.tap(find.byTooltip('Back to shop'));
    await tester.pumpAndSettle();
    expect(find.text('Shop home'), findsOneWidget);
  });
}
