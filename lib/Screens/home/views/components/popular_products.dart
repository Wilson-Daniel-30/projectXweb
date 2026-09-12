import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/product/product_card.dart';
import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../ViewModel/ProductViewModel.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import '../../../product/views/product_details_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..fetchProducts(),
      child: Consumer<ProductViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return Center(child: LoadingAnimationWidget.waveDots(
              color: primaryColor,
              size: 60,
            ));
          }
          if (vm.error != null) {
            return Center(child: kDebugMode? Text('Error: ${vm.error}') : Text(''));
          }

          final products = vm.products;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding / 2),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Popular products",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              // IconButton(
              //   onPressed: (){
              //         vm.runCompleteFlow();
              //   },
              //   icon: Icon(Icons.circle)
              // ),
              SizedBox(
                height: kIsWeb ? 276 : 235,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == products.length - 1 ? defaultPadding : 0,
                      ),
                      child: ProductCard(
                        image: product.image,
                        brandName: product.brandName,
                        title: product.title,
                        price: product.price,
                        priceAfterDiscount: product.priceAfterDiscount,
                        discountpercent: product.discountpercent,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(productModel: product,),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
