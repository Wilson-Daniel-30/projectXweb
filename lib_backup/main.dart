import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectx/theme/app_theme.dart';
import 'Screens/home/views/home_screen.dart';
import 'entry_point.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'ViewModel/CartViewModel.dart';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb
import 'Admin/ProductUploadScreen.dart';
import 'ViewModel/ProductViewModel.dart';
import 'ViewModel/SearchViewModel.dart';
import 'package:projectx/Screens/search/views/search_screen.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectx/Admin/DataBaseServices.dart';
import 'Screens/checkout/views/OrderConfirmationScreen.dart';
import 'LaunchScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA8v-bKF6sFUedc7j3LpFLBiIEMUn_FpSY",
        authDomain: "projectx-c2b3a.firebaseapp.com",
        projectId: "projectx-c2b3a",
        storageBucket: "projectx-c2b3a.appspot.com",
        messagingSenderId: "760673124560",
        appId: "1:760673124560:web:d9ad87ad48f919ef415ed5",
        measurementId: "G-1GSD8B1QZL", // optional
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()..fetchProducts()),
        ChangeNotifierProvider(create: (_) => FlashSaleViewModel()..fetchFlashSaleProducts()),
        // ProxyProvider<ProductViewModel,FlashSaleViewModel>(
        //   create: (_) {
        //     print("🟢 create FlashSaleViewModel");
        //     return FlashSaleViewModel();
        //   },
        //   update: (_, productVM, flashSaleVM) {
        //     print("🔄 update called");
        //     print("productVM.products.length = ${productVM.products.length}");
        //     print("flashSaleVM == null: ${flashSaleVM == null}");
        //     flashSaleVM ??= FlashSaleViewModel();
        //
        //     flashSaleVM!.updateFromProductList(productVM.products);
        //     return flashSaleVM;
        //   },
        // ),
        ProxyProvider<ProductViewModel, SearchViewModel>(
          update: (_, productVM, __) => SearchViewModel(productVM.products),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oliviya Occurance',
      theme: AppTheme.lightTheme(context),
      // Dark theme is inclided in the Full template
      themeMode: ThemeMode.light,

      // home: EntryPoint(), // <-- use `home` instead of `initialRoute`
      // home: LaunchScreen(), // <-- use `LaunchScreen` for App
      home: ProductUploadScreen(), // <-- use 'ProductUploadScreen' for uploading new products

      // home: kIsWeb? EntryPoint() : EntryPoint(), // <-- use `home` instead of `initialRoute`
    );
  }
}

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show GitHub Image')),
      body: Center(
        child: Image.network(
          'https://raw.githubusercontent.com/Wilson-Daniel/Assignment/main/38.png',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return const Text('Failed to load image');
          },
        ),
      ),
    );
  }
}
