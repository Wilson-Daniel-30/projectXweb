import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';

import '../../../../Components/product/secondary_product_card.dart';
import '../../../../constants.dart';
import '../../../../models/product_model.dart';
import 'package:projectx/ViewModel/MostPopularViewModel.dart';
import 'package:provider/provider.dart';


class MostPopular extends StatelessWidget {
  const MostPopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MostPopularViewModel()..fetchMostPopularProducts(),
        child: Consumer<MostPopularViewModel>(
            builder: (context,vm,child){
              if(vm.isLoading){
                return const Center(child: CircularProgressIndicator());
              }
              if (vm.error != null) {
                return Center(child: Text('Unexpected Error Occurred!!'));
              }
              final mostPopularProducts = vm.mostPopularProducts;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kIsWeb ? defaultPadding : defaultPadding / 2),
                  Padding(
                    padding: kIsWeb
                        ? const EdgeInsets.symmetric(horizontal: defaultPadding)
                        : const EdgeInsets.all(defaultPadding),
                    child: Text(
                      "New Arrival",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  if (kIsWeb) const SizedBox(height: defaultPadding),
                  SizedBox(
                    height: kIsWeb ? 128 : 114,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mostPopularProducts.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                          left: defaultPadding,
                          right: index == mostPopularProducts.length - 1
                              ? defaultPadding
                              : 0,
                        ),
                        child: SecondaryProductCard(
                          image: mostPopularProducts[index].image,
                          brandName: mostPopularProducts[index].brandName,
                          title: mostPopularProducts[index].title,
                          price: mostPopularProducts[index].price,
                          priceAfterDiscount:
                              mostPopularProducts[index].priceAfterDiscount,
                          discountpercent:
                              mostPopularProducts[index].discountpercent,
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  productModel: mostPopularProducts[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left:defaultPadding,right: defaultPadding,top: defaultPadding,bottom: defaultPadding),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF8F9FA), // light grey
                          Color(0xFFEDEEF0), // slightly darker
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.auto_awesome_outlined, color: Color(0xff0b2545), size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Disclaimer: These products are infused with true holy water sourced from the sacred Sardhana Church – The Basilica of Our Lady of Graces, Meerut – and other renowned churches. Each item has been prayerfully blessed by the Fathers of the Church to bring peace and divine grace to your home. 🕊",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              );
            }
        ),
    );


  }
}
