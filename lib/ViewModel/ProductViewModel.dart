import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';
import 'package:projectx/Admin/DataBaseServices.dart';
import 'dart:math';

class ProductViewModel extends ChangeNotifier {
  final List<ProductModel> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<List<ProductModel>> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await FirebaseFirestore.instance.collection('Products').get();
      _products.clear();
      _products.addAll(
        snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())),
      );

    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
    return products;
  }



  final List<Map<String, dynamic>> jsonData = [
    {
      "name": "Roshan D'Souza",
      "review": "The frame quality is top-notch and very durable.",
      "rating": 4.4,
      "title": "Strong Build",
      "location": "Goa",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Anjali Joseph",
      "review": "The Jesus portrait looks so peaceful and divine.",
      "rating": 4.5,
      "title": "Beautiful Portrait",
      "location": "Kerala",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Rakesh Kurien",
      "review": "Very lightweight and easy to mount on the wall.",
      "rating": 4.3,
      "title": "Easy to Hang",
      "location": "Delhi",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Mary Fernandes",
      "review": "I liked the smooth finish and clean design.",
      "rating": 4.2,
      "title": "Clean Look",
      "location": "Maharashtra",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Samuel Tirkey",
      "review": "Frame is sturdy and doesn’t feel cheap.",
      "rating": 4.4,
      "title": "Well Built",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Rebecca Raj",
      "review": "Looks great in my prayer corner. Simple and divine.",
      "rating": 4.5,
      "title": "Perfect for Prayer",
      "location": "Tamil Nadu",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "David Nayak",
      "review": "Good quality plastic used. Very neat edges.",
      "rating": 4.3,
      "title": "Neatly Made",
      "location": "Chhattisgarh",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Priya George",
      "review": "The front protection is clear and gives a nice view.",
      "rating": 4.4,
      "title": "Clear Cover",
      "location": "Kerala",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Sandeep Michael",
      "review": "Loved the print clarity of Jesus’ image.",
      "rating": 4.5,
      "title": "Sharp Image",
      "location": "Punjab",
      "timeAgo": "6 days ago",
      "verified": true
    },
    {
      "name": "Grace Kumari",
      "review": "Good size for small walls. Not too big or small.",
      "rating": 4.2,
      "title": "Right Size",
      "location": "Uttar Pradesh",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Ajay Thomas",
      "review": "Material feels solid and worth the price.",
      "rating": 4.3,
      "title": "Solid Material",
      "location": "Andhra Pradesh",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Lydia Yadav",
      "review": "The photo looks very divine and gives peace.",
      "rating": 4.5,
      "title": "Peaceful Look",
      "location": "Bihar",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "John Mahato",
      "review": "Loved the quality of back panel. Strong hold.",
      "rating": 4.4,
      "title": "Back Support",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Sandra Naik",
      "review": "The recycled material used is really nice.",
      "rating": 4.3,
      "title": "Eco-Friendly",
      "location": "Odisha",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Vinod Varghese",
      "review": "Simple and elegant design. Looks rich.",
      "rating": 4.4,
      "title": "Elegant Frame",
      "location": "Kerala",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Deepa Paul",
      "review": "It has a glossy shine which looks beautiful.",
      "rating": 4.2,
      "title": "Nice Finish",
      "location": "Delhi",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Stephen Xalxo",
      "review": "Back side support is strong and nicely built.",
      "rating": 4.3,
      "title": "Strong Back",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Anita Cherian",
      "review": "The photo looks calming and divine.",
      "rating": 4.5,
      "title": "Very Calming",
      "location": "Kerala",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Kiran Dungdung",
      "review": "Feels light but doesn’t feel weak. Good job.",
      "rating": 4.2,
      "title": "Good Quality",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Nancy Dominic",
      "review": "Frame edges are smooth and not sharp at all.",
      "rating": 4.4,
      "title": "Well Finished",
      "location": "Maharashtra",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Michael Pradhan",
      "review": "The portrait is printed really well. Looks holy.",
      "rating": 4.5,
      "title": "Holy Feel",
      "location": "West Bengal",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Elsa Kujur",
      "review": "Feels very strong even though it’s light.",
      "rating": 4.3,
      "title": "Surprisingly Tough",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Peter Mani",
      "review": "Glass-like front is clear and safe.",
      "rating": 4.5,
      "title": "Safe Display",
      "location": "Tamil Nadu",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Tina Jacob",
      "review": "Fits perfectly in my living room corner.",
      "rating": 4.4,
      "title": "Perfect Fit",
      "location": "Kerala",
      "timeAgo": "6 days ago",
      "verified": true
    },
    {
      "name": "Rahul Barla",
      "review": "ABS plastic quality is premium.",
      "rating": 4.2,
      "title": "Premium Plastic",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Angel Raj",
      "review": "Very light and easy to shift around.",
      "rating": 4.3,
      "title": "Lightweight",
      "location": "Delhi",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Daniel Raut",
      "review": "Edges are clean, no sharp parts.",
      "rating": 4.3,
      "title": "Smooth Design",
      "location": "Chhattisgarh",
      "timeAgo": "3 days ago",
      "verified": true
    },
    {
      "name": "Shiny Pothan",
      "review": "Plastic used feels strong and not cheap.",
      "rating": 4.4,
      "title": "Nice Plastic",
      "location": "Kerala",
      "timeAgo": "4 weeks ago",
      "verified": true
    },
    {
      "name": "George Minz",
      "review": "Very steady even on a small hook.",
      "rating": 4.2,
      "title": "Steady Hold",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Christina Ekka",
      "review": "Very clean look and minimal design.",
      "rating": 4.5,
      "title": "Simple Look",
      "location": "Jharkhand",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Suresh Antony",
      "review": "Size is ideal, not too bulky.",
      "rating": 4.3,
      "title": "Good Size",
      "location": "Andhra Pradesh",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Leena David",
      "review": "Very clean and clear printing. Sharp quality.",
      "rating": 4.5,
      "title": "Clear Image",
      "location": "Kerala",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Jaison Oraon",
      "review": "Lightweight and very easy to carry around.",
      "rating": 4.3,
      "title": "Light & Easy",
      "location": "Jharkhand",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Merlin D’Cruz",
      "review": "Looks very divine and calming.",
      "rating": 4.5,
      "title": "Divine Look",
      "location": "Goa",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Harish Kurmi",
      "review": "Strong back panel and secure support.",
      "rating": 4.4,
      "title": "Secure Back",
      "location": "Uttar Pradesh",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Lydia Fernandes",
      "review": "Very nice and neat edges all around.",
      "rating": 4.3,
      "title": "Neat Edges",
      "location": "Goa",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Kumar Paul",
      "review": "Good frame size for the price.",
      "rating": 4.2,
      "title": "Value for Money",
      "location": "Tamil Nadu",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Nisha Joseph",
      "review": "Easy to hang and looks good on the wall.",
      "rating": 4.3,
      "title": "Easy to Use",
      "location": "Kerala",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Biju Thomas",
      "review": "The front glass-like plastic is clear and safe.",
      "rating": 4.4,
      "title": "Clear Cover",
      "location": "Kerala",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Mary Dungdung",
      "review": "Lightweight and very sturdy.",
      "rating": 4.5,
      "title": "Strong Yet Light",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Joseph Michael",
      "review": "Print quality is excellent, very clear.",
      "rating": 4.5,
      "title": "Excellent Print",
      "location": "Kerala",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Selvin Kujur",
      "review": "Simple design, good for prayer rooms.",
      "rating": 4.2,
      "title": "Simple Design",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Alina D’Mello",
      "review": "The frame is solid and feels premium.",
      "rating": 4.4,
      "title": "Premium Feel",
      "location": "Goa",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Rahul Joseph",
      "review": "Size is perfect for my small wall space.",
      "rating": 4.3,
      "title": "Perfect Size",
      "location": "Delhi",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Sarah Prasad",
      "review": "Lightweight but does not look cheap.",
      "rating": 4.3,
      "title": "Good Build",
      "location": "Tamil Nadu",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Vinay Kumar",
      "review": "The plastic edges are smooth and safe.",
      "rating": 4.4,
      "title": "Safe Edges",
      "location": "Uttar Pradesh",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Elena George",
      "review": "Looks elegant and classy.",
      "rating": 4.5,
      "title": "Classy Look",
      "location": "Kerala",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Manoj Tirkey",
      "review": "Strong back and easy to mount.",
      "rating": 4.4,
      "title": "Strong & Easy",
      "location": "Jharkhand",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Grace Raj",
      "review": "The portrait has a peaceful aura.",
      "rating": 4.5,
      "title": "Peaceful Portrait",
      "location": "Kerala",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Sujit Yadav",
      "review": "Lightweight frame but very durable.",
      "rating": 4.3,
      "title": "Durable Frame",
      "location": "Bihar",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Maya Joseph",
      "review": "The frame looks rich and elegant.",
      "rating": 4.4,
      "title": "Rich Look",
      "location": "Kerala",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Thomas Ekka",
      "review": "Edges are very smooth and well done.",
      "rating": 4.2,
      "title": "Smooth Edges",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Lina Fernandes",
      "review": "Good size and perfect for gifting.",
      "rating": 4.3,
      "title": "Great Gift",
      "location": "Goa",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Ajit Thomas",
      "review": "Print clarity is excellent.",
      "rating": 4.5,
      "title": "Clear Print",
      "location": "Kerala",
      "timeAgo": "5 days ago",
      "verified": true
    },
    {
      "name": "Neha D'Silva",
      "review": "Easy to mount and looks beautiful.",
      "rating": 4.4,
      "title": "Easy Mount",
      "location": "Goa",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Raju Barla",
      "review": "Light but very sturdy frame.",
      "rating": 4.3,
      "title": "Sturdy Frame",
      "location": "Jharkhand",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Jessica Paul",
      "review": "Very neat finish and classy look.",
      "rating": 4.4,
      "title": "Classy Finish",
      "location": "Kerala",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Nitin Raj",
      "review": "Perfect for my small prayer corner.",
      "rating": 4.5,
      "title": "Perfect Size",
      "location": "Delhi",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Liza Kurien",
      "review": "Good quality plastic and photo clarity.",
      "rating": 4.3,
      "title": "Good Quality",
      "location": "Kerala",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "David Thomas",
      "review": "Simple design but elegant.",
      "rating": 4.2,
      "title": "Elegant Design",
      "location": "Tamil Nadu",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Sophia Fernandes",
      "review": "Great size and clear front cover.",
      "rating": 4.4,
      "title": "Good Size",
      "location": "Goa",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Rajesh D’Mello",
      "review": "Very sturdy and lightweight.",
      "rating": 4.3,
      "title": "Light & Sturdy",
      "location": "Kerala",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Monica Kurmi",
      "review": "The frame edges are smooth and safe.",
      "rating": 4.5,
      "title": "Safe Edges",
      "location": "Jharkhand",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Anil D'Souza",
      "review": "The Jesus portrait is very clear and beautiful.",
      "rating": 4.4,
      "title": "Clear Portrait",
      "location": "Goa",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Rekha Thomas",
      "review": "Perfect frame size for my home altar.",
      "rating": 4.3,
      "title": "Perfect Size",
      "location": "Kerala",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Vinod Kumar",
      "review": "Sturdy build with a nice glossy finish.",
      "rating": 4.4,
      "title": "Glossy Finish",
      "location": "Tamil Nadu",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Lilly George",
      "review": "Lightweight and looks very elegant.",
      "rating": 4.5,
      "title": "Elegant Look",
      "location": "Kerala",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Kiran Naik",
      "review": "Good plastic quality and nice edges.",
      "rating": 4.2,
      "title": "Good Quality",
      "location": "Goa",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Sonia D'Silva",
      "review": "Clear front cover protects the photo well.",
      "rating": 4.4,
      "title": "Protective Cover",
      "location": "Kerala",
      "timeAgo": "4 days ago",
      "verified": true
    },
    {
      "name": "Rajesh Kurien",
      "review": "Very sturdy frame, doesn’t feel cheap.",
      "rating": 4.3,
      "title": "Strong Frame",
      "location": "Delhi",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Meena Raj",
      "review": "Simple yet beautiful design.",
      "rating": 4.5,
      "title": "Beautiful Design",
      "location": "Kerala",
      "timeAgo": "3 weeks ago",
      "verified": true
    },
    {
      "name": "Thomas Dungdung",
      "review": "Nice finish and easy to mount.",
      "rating": 4.4,
      "title": "Easy to Mount",
      "location": "Jharkhand",
      "timeAgo": "2 weeks ago",
      "verified": true
    },
    {
      "name": "Pooja Joseph",
      "review": "The image looks divine and peaceful.",
      "rating": 4.5,
      "title": "Divine Image",
      "location": "Kerala",
      "timeAgo": "1 month ago",
      "verified": true
    },
    {
      "name": "Rahul D’Souza",
      "review": "Very light but durable frame.",
      "rating": 4.3,
      "title": "Durable Frame",
      "location": "Goa",
      "timeAgo": "1 week ago",
      "verified": true
    },
    {
      "name": "Nancy Thomas",
      "review": "Edges are smooth and well-finished.",
      "rating": 4.4,
      "title": "Smooth Edges",
      "location": "Kerala",
      "timeAgo": "3 weeks ago",
      "verified": true
    }
  ];

  List<int> randomNum = [12,14,9,7,11,4,8,6];

  Future<void> runCompleteFlow() async {
    // try {
      List<ProductModel> products = await fetchProducts();
      List<Review> allReviews = parseReviewsFromJson(jsonData);
      int lastIdx = 0;
      for(int i=0 ; i<2 ; i++){
        List<Review> newReviews = [];
        for(int j=lastIdx ; j<(lastIdx+randomNum[i]) ; j++){
          newReviews.add(allReviews[j]);
        }
        lastIdx = randomNum[i];
        ProductModel current = products[i];
        ProductModel newInstance = ProductModel(image: current.image, brandName: current.brandName+"new$i", title: current.title, price: current.price,
        customerReviews: current.customerReviews,discountpercent: current.discountpercent,imageList: current.imageList,mostPopular: current.mostPopular,
          priceAfterDiscount: current.priceAfterDiscount,productInfo: current.productInfo,productRating: current.productRating,reviews: newReviews
        );
        // newInstance.reviews = newReviews;
        // newInstance.title = current.title;
        // newInstance.price = current.price;
        // newInstance.brandName = current.brandName;
        // newInstance.productInfo = current.productInfo;
        // newInstance.priceAfterDiscount = current.priceAfterDiscount;
        // newInstance.discountpercent = current.discountpercent;
        // newInstance.image = current.image;
        // newInstance.productRating = current.productRating;
        // newInstance.imageList = current.imageList;
        // newInstance.mostPopular = current.mostPopular;
        // newInstance.customerReviews = current.customerReviews;
        print("created new instance");
        print(newInstance.title);
        print(newInstance.reviews);
        print("Send for ${newInstance.title} ${newInstance.reviews.length}");
        DataBaseServices().createProduct(newInstance);


      }
      //
      // distributeReviewsRandomly(products, allReviews);
      // await updateProductsInFirestore(products);
      // print("✅ All products updated with reviews.");
    // } catch (e) {
    //   print("❌ Error in flow: $e");
    // }
  }

  List<Review> parseReviewsFromJson(List<Map<String, dynamic>> jsonData) {
    return jsonData.map((e) => Review.fromJson(e)).toList();
  }

  void distributeReviewsRandomly(
      List<ProductModel> products,
      List<Review> allReviews,
      ) {
    final random = Random();
    int totalReviews = allReviews.length;
    int totalProducts = products.length;

    allReviews.shuffle(random);

    List<int> chunkSizes = [];
    int remaining = totalReviews;

    for (int i = 0; i < totalProducts; i++) {
      if (i == totalProducts - 1) {
        chunkSizes.add(remaining);
      } else {
        int maxSize = remaining - (totalProducts - i - 1);
        int chunkSize = random.nextInt(maxSize) + 1;
        chunkSizes.add(chunkSize);
        remaining -= chunkSize;
      }
    }

    int startIndex = 0;
    for (int i = 0; i < totalProducts; i++) {
      int size = chunkSizes[i];
      products[i].reviews = allReviews.sublist(startIndex, startIndex + size);
      startIndex += size;
    }
  }

  Future<void> updateProductsInFirestore(List<ProductModel> products) async {
    final collection = FirebaseFirestore.instance.collection('Products');


    for (var product in products) {
      print("productsreview${product.reviews}");
      // Assuming you have a way to get the doc id for each product (you may want to add id in ProductModel)
      // Otherwise, you need to fetch doc.id during fetch and pass it here to update.
      final query = await collection.where('title', isEqualTo: product.title).limit(1).get();

      if (query.docs.isNotEmpty) {
        final docId = query.docs.first.id;
        await collection.doc(docId).update(product.toJson());
        print("Updated product: ${product.title}");
      } else {
        print("Product not found for update: ${product.title}");
      }
    }
  }

}