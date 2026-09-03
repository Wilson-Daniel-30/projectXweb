import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/ProductReviewsScreen.dart';
import 'package:projectx/Screens/product/views/components/notify_me_card.dart';
import 'package:projectx/Screens/product/views/components/product_images.dart';
import 'package:projectx/Screens/product/views/components/product_info.dart';
import 'package:projectx/Screens/product/views/components/product_list_tile.dart';
import 'package:projectx/Screens/product/views/product_buy_now_screen.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/ViewModel/ProductDetailsScreenViewModel.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/models/product_model.dart';
import 'package:provider/provider.dart';

import '../Components/cart_button.dart';
import '../Components/custom_modal_bottom_sheet.dart';
import '../Components/product/product_card.dart';
import '../Components/review_card.dart';
import '../constants.dart';

/// Window width at which product details switch from a stacked phone
/// layout to image | details on one row. Uses MediaQuery (the browser
/// window), not a nested LayoutBuilder, so a max-width wrapper cannot
/// keep this on the mobile stack.
const double kProductDetailsWideBreakpoint = 800;

const Key kProductDetailsWideRowKey = Key('productDetailsWideRow');
const Key kProductDetailsStackedKey = Key('productDetailsStacked');

class ProductDetailsScreenWeb extends StatelessWidget {
  const ProductDetailsScreenWeb({
    super.key,
    required this.productModel,
    this.isProductAvailable = true,
  });

  final ProductModel productModel;
  final bool isProductAvailable;

  void _openReviews(BuildContext context) {
    customModalBottomSheet(
      context,
      height: MediaQuery.of(context).size.height * 0.92,
      child: ProductReviewsScreen(
        customerReviewList: productModel.reviews,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final webImages = productModel.webImageList
            ?.where((url) => url.isNotEmpty)
            .toList() ??
        const <String>[];
    final galleryImages = productModel.imageList
            ?.where((url) => url.isNotEmpty)
            .toList() ??
        const <String>[];
    final images = webImages.isNotEmpty
        ? webImages
        : galleryImages.isNotEmpty
            ? galleryImages
            : [productModel.image];
    final rating = productModel.productRating;
    final isFullScreen = productModel.title.contains("Emmanuel Frame");

    return ChangeNotifierProvider(
      create: (_) => ProductDetailScreenViewModel(
        ProductViewModel:
            Provider.of<ProductViewModel>(context, listen: false),
        FlashSaleViewModel:
            Provider.of<FlashSaleViewModel>(context, listen: false),
      ),
      child: Consumer<ProductDetailScreenViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            bottomNavigationBar: isProductAvailable
                ? CartButton(
                    price: productModel.priceAfterDiscount ?? productModel.price,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ProductBuyNowScreen(productModel: productModel),
                      );
                    },
                  )
                : NotifyMeCard(
                    isNotify: false,
                    onChanged: (value) {},
                  ),
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  final screenWidth = MediaQuery.sizeOf(context).width;
                  final isWide =
                      screenWidth >= kProductDetailsWideBreakpoint;
                  final imageWidth =
                      (screenWidth * 0.42).clamp(280.0, 480.0);

                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        floating: true,
                      ),
                      if (isWide)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding,
                            ),
                            child: Row(
                              key: kProductDetailsWideRowKey,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: imageWidth,
                                  child: ProductImages(
                                    asSliver: false,
                                    fullScreen: isFullScreen,
                                    aspectRatio: isFullScreen ? 0.8 : 1,
                                    images: images,
                                  ),
                                ),
                                const SizedBox(width: defaultPadding),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ProductInfo(
                                        asSliver: false,
                                        brand: productModel.brandName,
                                        title: productModel.title,
                                        isAvailable: isProductAvailable,
                                        description:
                                            productModel.productInfo ?? '',
                                        rating: rating?.rating ?? 0,
                                        numOfReviews:
                                            rating?.numOfReviews ?? 0,
                                      ),
                                      ProductListTile(
                                        asSliver: false,
                                        svgSrc: "assets/icons/Chat.svg",
                                        title: "Reviews",
                                        isShowBottomBorder: true,
                                        press: () => _openReviews(context),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          defaultPadding,
                                        ),
                                        child: ReviewCard(
                                          rating: rating?.rating ?? 0,
                                          numOfReviews:
                                              rating?.numOfReviews ?? 0,
                                          numOfFiveStar:
                                              rating?.numOfFiveStar ?? 0,
                                          numOfFourStar:
                                              rating?.numOfFourStar ?? 0,
                                          numOfThreeStar:
                                              rating?.numOfThreeStar ?? 0,
                                          numOfTwoStar:
                                              rating?.numOfTwoStar ?? 0,
                                          numOfOneStar:
                                              rating?.numOfOneStar ?? 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else ...[
                        ProductImages(
                          key: kProductDetailsStackedKey,
                          fullScreen: isFullScreen,
                          images: images,
                        ),
                        ProductInfo(
                          brand: productModel.brandName,
                          title: productModel.title,
                          isAvailable: isProductAvailable,
                          description: productModel.productInfo ?? '',
                          rating: rating?.rating ?? 0,
                          numOfReviews: rating?.numOfReviews ?? 0,
                        ),
                        ProductListTile(
                          svgSrc: "assets/icons/Chat.svg",
                          title: "Reviews",
                          isShowBottomBorder: true,
                          press: () => _openReviews(context),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: ReviewCard(
                              rating: rating?.rating ?? 0,
                              numOfReviews: rating?.numOfReviews ?? 0,
                              numOfFiveStar: rating?.numOfFiveStar ?? 0,
                              numOfFourStar: rating?.numOfFourStar ?? 0,
                              numOfThreeStar: rating?.numOfThreeStar ?? 0,
                              numOfTwoStar: rating?.numOfTwoStar ?? 0,
                              numOfOneStar: rating?.numOfOneStar ?? 0,
                            ),
                          ),
                        ),
                      ],
                      SliverPadding(
                        padding: const EdgeInsets.all(defaultPadding),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            "You may also like",
                            style: Theme.of(context).textTheme.titleSmall!,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 276,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.combinedList.length,
                            itemBuilder: (context, index) {
                              final item = viewModel.combinedList[index];
                              if (item.title == productModel.title) {
                                return const SizedBox();
                              }
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: defaultPadding,
                                  right: index == 4 ? defaultPadding : 0,
                                ),
                                child: ProductCard(
                                  image: item.image,
                                  title: item.title,
                                  brandName: item.brandName,
                                  price: item.price,
                                  priceAfterDiscount: item.priceAfterDiscount,
                                  discountpercent: item.discountpercent,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsScreenWeb(
                                          productModel: item,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: defaultPadding),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
