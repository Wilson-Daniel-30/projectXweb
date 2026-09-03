import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/ViewModel/SearchViewModel.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/Components/product/product_card.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SearchViewModel>(context);

    if (kIsWeb) {
      return _SearchScreenBodyWeb(vm: vm);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: EdgeInsets.only(left: defaultPadding+10,right: defaultPadding+10,bottom: defaultPadding,top: defaultPadding/2),
        child: Column(
          children: [
          TextField(
            onChanged: vm.search,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: 'Search for products...',
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadious)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0b2545)), // focused state
                borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadious)),
              ),
            ),
            cursorColor: Color(0xff0b2545),

          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 2.9 / 5,
              ),
              scrollDirection: Axis.vertical,
              itemCount: vm.filteredProducts.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  bottom: defaultPadding/2,
                  top: index == 0 || index == 1
                      ? defaultPadding
                      : 0,
                ),
                child: ProductCard(
                  image: vm.filteredProducts[index].image,
                  brandName: vm.filteredProducts[index].brandName,
                  title: vm.filteredProducts[index].title,
                  price: vm.filteredProducts[index].price,
                  priceAfterDiscount: vm.filteredProducts[index].priceAfterDiscount,
                  discountpercent: vm.filteredProducts[index].discountpercent,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailsScreen(productModel: vm.filteredProducts[index],)),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),)
    );
  }
}

class _SearchScreenBodyWeb extends StatelessWidget {
  const _SearchScreenBodyWeb({required this.vm});

  final SearchViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              defaultPadding,
              defaultPadding / 2,
              defaultPadding,
              defaultPadding,
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: vm.search,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'Search for products...',
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultBorderRadious),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff0b2545)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultBorderRadious),
                      ),
                    ),
                  ),
                  cursorColor: const Color(0xff0b2545),
                ),
                const SizedBox(height: defaultPadding),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final count = constraints.maxWidth >= 960
                          ? 4
                          : constraints.maxWidth >= 640
                              ? 3
                              : 2;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: count,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: vm.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = vm.filteredProducts[index];
                          return ProductCard(
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
                                  builder: (context) => ProductDetailsScreen(
                                    productModel: product,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
