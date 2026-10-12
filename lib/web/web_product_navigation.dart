import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/entry_point.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/web/web_product_deep_link.dart';
import 'package:projectx/web/web_routes.dart';

/// Goes back to the shop. Deep links have no stack to pop, so replace with home.
void navigateBackToShop(BuildContext context) {
  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    navigator.pop();
    return;
  }
  navigator.pushNamedAndRemoveUntil(kShopRoute, (route) => false);
}

/// Opens product details. On web this updates the address bar to `/product/<slug>`.
void openProductDetails(BuildContext context, ProductModel product) {
  if (kIsWeb) {
    Navigator.of(context).pushNamed(productPathFromTitle(product.title));
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProductDetailsScreen(productModel: product),
    ),
  );
}

Route<dynamic> onGenerateWebRoute(RouteSettings settings) {
  final name = settings.name ?? kShopRoute;
  final slug = productSlugFromPath(name);
  if (slug != null) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => WebProductDeepLinkScreen(slug: slug),
    );
  }
  if (name == kShopRoute || name == '/shop' || name == '/home') {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const EntryPoint(),
    );
  }
  return MaterialPageRoute(
    settings: settings,
    builder: (_) => const WebProductNotFoundScreen(),
  );
}
