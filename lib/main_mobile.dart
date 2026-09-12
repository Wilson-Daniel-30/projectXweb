import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectx/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:projectx/Admin/ProductUploadScreen.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/ViewModel/SearchViewModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(
          create: (_) => ProductViewModel()..fetchProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => FlashSaleViewModel()..fetchFlashSaleProducts(),
        ),
        ProxyProvider<ProductViewModel, SearchViewModel>(
          update: (_, productVM, __) => SearchViewModel(productVM.products),
        ),
      ],
      child: const MobileApp(),
    ),
  );
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oliviya Occurance',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      home: const ProductUploadScreen(),
    );
  }
}
