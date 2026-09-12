import 'package:flutter/material.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/models/product_model.dart';
import 'package:projectx/components/product/product_card.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/Screens/search/views/components/search_form.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/Screens/product/views/product_details_screen.dart';
import 'package:projectx/ViewModel/SearchViewModel.dart';
import 'package:projectx/Screens/search/views/SearchScreenBody.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Widget build(BuildContext context) {
    final products = Provider.of<ProductViewModel>(context, listen: false).products;

    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(products),
      child: SearchScreenBody(),
    );
  }
}
