import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projectx/Screens/product/views/size_guide_screen.dart';

import '../../../Components/cart_button.dart';
import '../../../Components/custom_modal_bottom_sheet.dart';
import '../../../Components/network_image_with_loader.dart';
import '../../../constants.dart';
import 'added_to_cart_message_screen.dart';
import 'components/product_list_tile.dart';
import 'components/product_quantity.dart';
import 'components/selected_colors.dart';
import 'components/selected_size.dart';
import 'components/unit_price.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:provider/provider.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/ViewModel/ProductBuyNowViewModel.dart';
import 'package:projectx/HelperFunctions.dart';

class ProductBuyNowScreen extends StatefulWidget {
  ProductModel productModel;

  ProductBuyNowScreen({super.key,required this.productModel});

  @override
  _ProductBuyNowScreenState createState() => _ProductBuyNowScreenState();
}

class _ProductBuyNowScreenState extends State<ProductBuyNowScreen> {



  @override

  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => ProductBuyNowViewModel(
        productModel: widget.productModel,
        cartViewModel: cartViewModel,
      ),
      child: const _ProductBuyNowView(),
    );
  }
}

class _ProductBuyNowView extends StatefulWidget {
  const _ProductBuyNowView();

  @override
  State<_ProductBuyNowView> createState() => _ProductBuyNowViewState();
}

class _ProductBuyNowViewState extends State<_ProductBuyNowView> {
  final _scrollController = ScrollController();
  final _quantityKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _revealQuantity() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = _quantityKey.currentContext;
      if (target != null) {
        Scrollable.ensureVisible(
          target,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          alignment: 0.2,
        );
      } else if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductBuyNowViewModel>(context);

    return Scaffold(
      bottomNavigationBar: CartButton(
        price: viewModel.totalPrice,
        title: "Add to cart",
        subTitle: "Total price",
        press: () {
          if(viewModel.noOfItem!=0){
            viewModel.addToCart();
            customModalBottomSheet(
              context,
              isDismissible: false,
              child: AddedToCartMessageScreen(finalPrice: viewModel.totalPrice,),
            );
          }else{
            HelperFunctions.showSnackBar(context,"Oops! add at least 1 item to the cart.",3);
            if (kIsWeb) {
              _revealQuantity();
            }
          }

        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            child: Row(
              children: [
                const BackButton(),
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    viewModel.productModel.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding + 20),
                    child: AspectRatio(
                      aspectRatio: 1.05,
                      child: NetworkImageWithLoader(viewModel.productModel.image),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      key: _quantityKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: UnitPrice(
                            price: viewModel.productModel.price,
                            priceAfterDiscount: viewModel.productModel.priceAfterDiscount,
                          ),
                        ),
                        ProductQuantity(
                          numOfItem: viewModel.noOfItem,
                          onIncrement: viewModel.incrementItem,
                          onDecrement: viewModel.decrementItem,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: Divider()),
                SliverToBoxAdapter(
                  child: SelectedSize(
                    sizes: const ["21*30cm"],
                    selectedIndex: viewModel.selectedSizeIndex,
                    press: viewModel.selectSize,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: defaultPadding))
              ],
            ),
          )
        ],
      ),
    );
  }
}