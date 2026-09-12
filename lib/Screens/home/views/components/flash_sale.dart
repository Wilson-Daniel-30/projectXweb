import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:provider/provider.dart';
import '../../../../components/Banner/M/banner_m_with_counter.dart';
import '../../../../components/product/product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FlashSaleViewModel()..fetchFlashSaleProducts(),
        child: Consumer<FlashSaleViewModel>(
          builder: (context,vm,child){
            if (vm.isLoading) {
              return Center(child: LoadingAnimationWidget.waveDots(
                color: primaryColor,
                size: 60,
              ));
            }
            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }

            final flashSaleProducts = vm.flashSaleProducts;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // While loading show 👇
                // const BannerMWithCounterSkelton(),
                BannerMWithCounter(
                  duration: const Duration(hours: 8),
                  text: "Super Flash Sale \n50% Off",
                  press: () {},
                ),
                SizedBox(height: kIsWeb ? defaultPadding : defaultPadding / 2),
                Padding(
                  padding: kIsWeb
                      ? const EdgeInsets.symmetric(horizontal: defaultPadding)
                      : const EdgeInsets.all(defaultPadding),
                  child: Text(
                    "Flash sale",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (kIsWeb) const SizedBox(height: defaultPadding),
                // While loading show 👇
                // const ProductsSkelton(),
                SizedBox(
                  height: kIsWeb ? 276 : 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Find demoFlashSaleProducts on models/ProductModel.dart
                    itemCount: flashSaleProducts.length,
                    itemBuilder: (context, index) {
                      final flashProduct = flashSaleProducts[index];
                      return Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right: index == flashSaleProducts.length - 1
                            ? defaultPadding
                            : 0,
                      ),
                      child: ProductCard(
                        image: flashProduct.image,
                        brandName: flashProduct.brandName,
                        title: flashProduct.title,
                        price: flashProduct.price,
                        priceAfterDiscount: flashProduct.priceAfterDiscount,
                        discountpercent: flashProduct.discountpercent,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductDetailsScreen(productModel: flashProduct,)),
                          );
                        },
                      ),
                    );
                    }
                  ),
                ),

              ],
            );
          },
        ),
    );

  }
}
