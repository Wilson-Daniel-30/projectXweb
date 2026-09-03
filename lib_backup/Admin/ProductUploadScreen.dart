import 'package:flutter/material.dart';
import 'package:projectx/Admin/DataBaseServices.dart';

import '../models/product_model.dart';

class ProductUploadScreen extends StatefulWidget {
  const ProductUploadScreen({super.key});

  @override
  State<ProductUploadScreen> createState() => _ProductUploadScreenState();
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final brandNameController = TextEditingController();
  final mainImageController = TextEditingController();
  final List<TextEditingController> imageListControllers =
  List.generate(5, (_) => TextEditingController());
  final priceController = TextEditingController();
  final priceAfterDiscountController = TextEditingController();
  final discountPercentController = TextEditingController();
  final productInfoController = TextEditingController();

  final ratingController = TextEditingController();
  final numReviewsController = TextEditingController();
  final star5Controller = TextEditingController();
  final star4Controller = TextEditingController();
  final star3Controller = TextEditingController();
  final star2Controller = TextEditingController();
  final star1Controller = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    brandNameController.dispose();
    mainImageController.dispose();
    for (var c in imageListControllers) {
      c.dispose();
    }
    priceController.dispose();
    priceAfterDiscountController.dispose();
    discountPercentController.dispose();
    productInfoController.dispose();
    ratingController.dispose();
    numReviewsController.dispose();
    star5Controller.dispose();
    star4Controller.dispose();
    star3Controller.dispose();
    star2Controller.dispose();
    star1Controller.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      final newProduct = ProductModel(
          title: titleController.text,
          brandName: brandNameController.text,
          image: mainImageController.text,
          price: double.parse(priceController.text),
          priceAfterDiscount: double.parse(priceAfterDiscountController.text),
          discountpercent: int.parse(discountPercentController.text),
          productInfo: productInfoController.text,
          imageList: imageListControllers
              .map((c) => c.text)
              .where((url) => url.isNotEmpty)
              .toList(),
          productRating: ProductRating(
              rating: double.parse(ratingController.text),
              numOfReviews: int.parse(numReviewsController.text),
              numOfFiveStar: int.parse(star5Controller.text),
              numOfFourStar: int.parse(star4Controller.text),
              numOfThreeStar: int.parse(star3Controller.text),
              numOfTwoStar: int.parse(star2Controller.text),
              numOfOneStar: int.parse(star1Controller.text)
          )
          );

      print(newProduct); // Replace this with Firestore upload
      DataBaseServices().createProduct(newProduct);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product data submitted!")),
      );
    }
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator: (value) =>
        value == null || value.isEmpty ? 'Required' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text("Basic Info",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                buildTextField("Title", titleController),
                buildTextField("Brand Name", brandNameController),
                buildTextField("Main Image URL", mainImageController),
                buildTextField("Price", priceController,
                    type: TextInputType.number),
                buildTextField("Price After Discount",
                    priceAfterDiscountController,
                    type: TextInputType.number),
                buildTextField("Discount Percent", discountPercentController,
                    type: TextInputType.number),
                buildTextField("Product Info", productInfoController),

                const SizedBox(height: 10),
                const Text("Image List (up to 5)",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                for (int i = 0; i < imageListControllers.length; i++)
                  buildTextField("Image URL ${i + 1}", imageListControllers[i]),

                const SizedBox(height: 10),
                const Text("Product Rating",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                buildTextField("Average Rating", ratingController,
                    type: TextInputType.number),
                buildTextField("Number of Reviews", numReviewsController,
                    type: TextInputType.number),
                buildTextField("5 Star Count", star5Controller,
                    type: TextInputType.number),
                buildTextField("4 Star Count", star4Controller,
                    type: TextInputType.number),
                buildTextField("3 Star Count", star3Controller,
                    type: TextInputType.number),
                buildTextField("2 Star Count", star2Controller,
                    type: TextInputType.number),
                buildTextField("1 Star Count", star1Controller,
                    type: TextInputType.number),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submit,
                  child: const Text("Submit Product"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
