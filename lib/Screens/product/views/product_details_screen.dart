import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projectx/Screens/product/views/product_returns_screen.dart';
import '../../../components/cart_button.dart';
import '../../../components/custom_modal_bottom_sheet.dart';
import '../../../components/product/product_card.dart';
import '../../../components/review_card.dart';
import '../../../constants.dart';
import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import 'product_buy_now_screen.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/Screens/product/views/ProductReviewsScreen.dart';
import 'package:projectx/ViewModel/ProductDetailsScreenViewModel.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:provider/provider.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/web/product_details_web.dart';

class ProductDetailsScreen extends StatelessWidget {
   ProductModel productModel;
   ProductDetailsScreen({super.key, this.isProductAvailable = true,required this.productModel});
   bool isProductAvailable;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return ProductDetailsScreenWeb(
        productModel: productModel,
        isProductAvailable: isProductAvailable,
      );
    }
    print("imagelistcheck ${productModel.imageList!.length} ${productModel.webImageList!.length}");
    return ChangeNotifierProvider(
        create: (_) => ProductDetailScreenViewModel(
          ProductViewModel: Provider.of<ProductViewModel>(context,listen:false),
          FlashSaleViewModel: Provider.of<FlashSaleViewModel>(context,listen:false)
        ),

        child: Consumer<ProductDetailScreenViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
            bottomNavigationBar: isProductAvailable
                ? CartButton(
                    price: productModel.priceAfterDiscount??productModel.price,
                    press: () {
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ProductBuyNowScreen(productModel: productModel,),
                      );
                    },
                  )
                :
             NotifyMeCard(
                    isNotify: false,
                    onChanged: (value) {},
                  ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    actions: [
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: SvgPicture.asset("assets/icons/Bookmark.svg",
                      //       color: Theme.of(context).textTheme.bodyLarge!.color),
                      // ),
                    ],
                  ),
                  ProductImages(

                    fullScreen: productModel.title.contains("Emmanuel Frame") ? true : false,
                    images: productModel.imageList??[],
                  ),
                  ProductInfo(
                    brand: productModel.brandName,
                    title: productModel.title,
                    isAvailable: isProductAvailable,
                    description: productModel.productInfo!,
                    rating: productModel.productRating!.rating,
                    numOfReviews: productModel.productRating!.numOfReviews,
                  ),
                  // ProductListTile(
                  //   svgSrc: "assets/icons/Return.svg",
                  //   title: "Returns",
                  //   isShowBottomBorder: true,
                  //   press: () {
                  //     customModalBottomSheet(
                  //       context,
                  //       height: MediaQuery.of(context).size.height * 0.92,
                  //       child: const ProductReturnsScreen(),
                  //     );
                  //   },
                  // ),
                  ProductListTile(
                    svgSrc: "assets/icons/Chat.svg",
                    title: "Reviews",
                    isShowBottomBorder: true,
                    press: () {
                      print("productModel!.customerReviews.runtimeType");
                      print(productModel!.reviews);
                      customModalBottomSheet(
                        context,
                        height: MediaQuery.of(context).size.height * 0.92,
                        child: ProductReviewsScreen(customerReviewList: productModel!.reviews),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: ReviewCard(
                        rating: productModel!.productRating!.rating,
                        numOfReviews: productModel!.productRating!.numOfReviews,
                        numOfFiveStar: productModel!.productRating!.numOfFiveStar,
                        numOfFourStar: productModel!.productRating!.numOfFourStar,
                        numOfThreeStar: productModel!.productRating!.numOfThreeStar,
                        numOfTwoStar: productModel!.productRating!.numOfTwoStar,
                        numOfOneStar: productModel!.productRating!.numOfOneStar!,
                      ),
                    ),
                  ),

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
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.combinedList.length,
                        itemBuilder: (context, index) => viewModel.combinedList[index].title!= productModel.title?Padding(
                          padding: EdgeInsets.only(
                              left: defaultPadding,
                              right: index == 4 ? defaultPadding : 0),
                          child: ProductCard(
                            image: viewModel.combinedList[index]!.image,
                            title: viewModel.combinedList[index]!.title,
                            brandName: viewModel.combinedList[index]!.brandName,
                            price: viewModel.combinedList[index]!.price,
                            priceAfterDiscount: viewModel.combinedList[index]!.priceAfterDiscount,
                            discountpercent: viewModel.combinedList[index]!.discountpercent,
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(productModel: viewModel.combinedList[index],),
                                ),
                              );
                            },
                          ),
                        ): Container(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: defaultPadding),
                  )
                    ],
                  ),
            ),
            );
          },
        ),
    );
  }
}
