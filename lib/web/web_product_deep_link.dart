import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/web/web_product_navigation.dart';
import 'package:provider/provider.dart';

/// Resolves `/product/<slug>` after [ProductViewModel] finishes loading.
class WebProductDeepLinkScreen extends StatelessWidget {
  const WebProductDeepLinkScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading && vm.products.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final product = vm.findBySlug(slug);
        if (product == null) {
          return WebProductNotFoundScreen(slug: slug);
        }
        return ProductDetailsScreen(productModel: product);
      },
    );
  }
}

class WebProductNotFoundScreen extends StatelessWidget {
  const WebProductNotFoundScreen({super.key, this.slug});

  final String? slug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back to shop',
          onPressed: () => navigateBackToShop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Product not found',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                slug == null || slug!.isEmpty
                    ? 'This page does not exist.'
                    : 'We could not find a product for "$slug".',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  );
                },
                child: const Text('Back to shop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
