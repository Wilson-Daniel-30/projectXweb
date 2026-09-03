

import '../constants.dart';
class ProductModel {
  final String image;
  final String brandName;
  final String title;
  final double price;
  final double? priceAfterDiscount;
  final int? discountpercent;
  final List<String>? imageList;
  final List<String>? webImageList;
  final String? productInfo;
  final ProductRating? productRating;
  final List<CustomerReview>? customerReviews;
  final bool? mostPopular;
  List<Review> reviews;



  ProductModel({
    required this.image,
    required this.brandName,
    required this.title,
    required this.price,
    this.priceAfterDiscount,
    this.discountpercent,
    this.imageList,
    this.webImageList,
    this.productInfo,
    this.productRating,
    this.customerReviews,
    this.mostPopular,
    this.reviews = const [], // default empty list

  });

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      image: data['image'],
      brandName: data['brandName'],
      title: data['title'],
      price: double.parse(data['price'].toString()),
      priceAfterDiscount: data['priceAfterDiscount'] != null
          ? double.tryParse(data['priceAfterDiscount'].toString())
          : null,
      discountpercent: data['discountpercent'] != null
          ? int.tryParse(data['discountpercent'].toString())
          : null,
      imageList: data['ImageList'] != null
          ? List<String>.from(data['ImageList'])
          : [],
      webImageList: data['WebImageList'] != null
          ? List<String>.from(data['WebImageList'])
          : [],
      productInfo: data['ProductInfo'],
      productRating: data['ProductRating'] != null
          ? ProductRating.fromMap(data['ProductRating'])
          : null,
      customerReviews: data['customerReviews'] != null
          ? List<CustomerReview>.from(
          data['customerReviews'].map((e) => CustomerReview.fromMap(e)))
          : [], // 🔥 Parse the customer reviews
      mostPopular: data['mostPopular'] ?? false, // ✅ Handle missing/null safely
      reviews: data['reviews'] != null
          ? List<Review>.from((data['reviews'] as List).map((r) => Review.fromJson(r)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'brandName': brandName,
      'title': title,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'discountpercent': discountpercent,
      'ImageList': imageList,
      'ProductInfo': productInfo,
      'ProductRating': productRating?.toJson(),
      'customerReviews': customerReviews?.map((e) => e.toJson()).toList(),
      'mostPopular': mostPopular,
      'reviews': reviews.map((r) => r.toJson()).toList(),

    };
  }

}


class ProductRating {
  final int numOfFiveStar;
  final int numOfFourStar;
  final int numOfThreeStar;
  final int numOfTwoStar;
  final int numOfOneStar;
  final int numOfReviews;
  final double rating;

  ProductRating({
    required this.numOfFiveStar,
    required this.numOfFourStar,
    required this.numOfThreeStar,
    required this.numOfTwoStar,
    required this.numOfOneStar,
    required this.numOfReviews,
    required this.rating,
  });

  factory ProductRating.fromMap(Map<String, dynamic> data) {
    return ProductRating(
      numOfFiveStar: data['numOfFiveStar'],
      numOfFourStar: data['numOfFourStar'],
      numOfThreeStar: data['numOfThreeStar'],
      numOfTwoStar: data['numOfTwoStar'],
      numOfOneStar: data['numOfOneStar'],
      numOfReviews: data['numOfReviews'],
      rating: data['rating'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'numOfFiveStar': numOfFiveStar,
      'numOfFourStar': numOfFourStar,
      'numOfThreeStar': numOfThreeStar,
      'numOfTwoStar': numOfTwoStar,
      'numOfOneStar': numOfOneStar,
      'numOfReviews': numOfReviews,
      'rating': rating,
    };
  }
}

class CustomerReview {
  final String location;
  final String name;
  final String rating;
  final String review;
  final String timeAgo;
  final String title;
  final String verified;

  CustomerReview({
    required this.location,
    required this.name,
    required this.rating,
    required this.review,
    required this.timeAgo,
    required this.title,
    required this.verified,
  });

  factory CustomerReview.fromMap(Map<String, dynamic> data) {
    return CustomerReview(
      location: data['location'],
      name: data['name'],
      rating: data['rating'],
      review: data['review'],
      timeAgo: data['timeAgo'],
      title: data['title'],
      verified: data['verified'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'name': name,
      'rating': rating,
      'review': review,
      'timeAgo': timeAgo,
      'title': title,
      'verified': verified,
    };
  }
}


class Review {
  final String name;
  final String review;
  final double rating;
  final String title;
  final String location;
  final String timeAgo;
  final bool verified;

  Review({
    required this.name,
    required this.review,
    required this.rating,
    required this.title,
    required this.location,
    required this.timeAgo,
    required this.verified,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    name: json['name'],
    review: json['review'],
    rating: double.parse(json['rating'].toString()),
    title: json['title'],
    location: json['location'],
    timeAgo: json['timeAgo'],
    verified: json['verified'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'review': review,
    'rating': rating,
    'title': title,
    'location': location,
    'timeAgo': timeAgo,
    'verified': verified,
  };
}



List<ProductModel> demoPopularProducts = [
  ProductModel(
    image: productDemoImg1,
    title: "Mountain Warehouse for Women",
    brandName: "Lipsy london",
    price: 540,
    priceAfterDiscount: 420,
    discountpercent: 20,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
  ),
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountpercent: 5,
  ),
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountpercent: 5,
  ),
];
List<ProductModel> demoFlashSaleProducts = [
  ProductModel(
    image: productDemoImg5,
    title: "FS - Nike Air Max 270 Really React",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountpercent: 40,
  ),
  ProductModel(
    image: productDemoImg6,
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfterDiscount: 680,
    discountpercent: 15,
  ),
];
List<ProductModel> demoBestSellersProducts = [
  ProductModel(
    image: "https://i.imgur.com/tXyOMMG.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 390.36,
    discountpercent: 40,
  ),
  ProductModel(
    image: "https://i.imgur.com/h2LqppX.png",
    title: "white satin corset top",
    brandName: "Lipsy london",
    price: 1264,
    priceAfterDiscount: 1200.8,
    discountpercent: 5,
  ),
  ProductModel(
    image: productDemoImg4,
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 800,
    priceAfterDiscount: 680,
    discountpercent: 15,
  ),
];
List<ProductModel> kidsProducts = [
  ProductModel(
    image: "https://i.imgur.com/dbbT6PA.png",
    title: "Green Poplin Ruched Front",
    brandName: "Lipsy london",
    price: 650.62,
    priceAfterDiscount: 590.36,
    discountpercent: 24,
  ),
  ProductModel(
    image: "https://i.imgur.com/7fSxC7k.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 650.62,
  ),
  ProductModel(
    image: "https://i.imgur.com/pXnYE9Q.png",
    title: "Ruffle-Sleeve Ponte-Knit Sheath ",
    brandName: "Lipsy london",
    price: 400,
  ),
  ProductModel(
    image: "https://i.imgur.com/V1MXgfa.png",
    title: "Green Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 400,
    priceAfterDiscount: 360,
    discountpercent: 20,
  ),
  ProductModel(
    image: "https://i.imgur.com/8gvE5Ss.png",
    title: "Printed Sleeveless Tiered Swing Dress",
    brandName: "Lipsy london",
    price: 654,
  ),
  ProductModel(
    image: "https://i.imgur.com/cBvB5YB.png",
    title: "Mountain Beta Warehouse",
    brandName: "Lipsy london",
    price: 250,
  ),
];
