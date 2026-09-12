import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectx/ViewModel/CartViewModel.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/ViewModel/ProductViewModel.dart';
import 'package:projectx/ViewModel/SearchViewModel.dart';
import 'package:projectx/theme/app_theme.dart';
import 'package:projectx/LaunchScreen.dart';
import 'package:provider/provider.dart';

Future<void> runWebStorefront() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA8v-bKF6sFUedc7j3LpFLBiIEMUn_FpSY",
      authDomain: "projectx-c2b3a.firebaseapp.com",
      projectId: "projectx-c2b3a",
      storageBucket: "projectx-c2b3a.appspot.com",
      messagingSenderId: "760673124560",
      appId: "1:760673124560:web:d9ad87ad48f919ef415ed5",
      measurementId: "G-1GSD8B1QZL",
    ),
  );

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
      child: const WebStorefrontApp(),
    ),
  );
}

class WebStorefrontApp extends StatelessWidget {
  const WebStorefrontApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oliviya Occurance',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      home: LaunchScreen(),
    );
  }
}
