class ProductRating {
  final String rating;
  final String numOfReviews;
  final String numOfFiveStar;
  final String numOfFourStar;
  final String numOfThreeStar;
  final String numOfTwoStar;
  final String numOfOneStar;

  ProductRating({
    required this.rating,
    required this.numOfReviews,
    required this.numOfFiveStar,
    required this.numOfFourStar,
    required this.numOfThreeStar,
    required this.numOfTwoStar,
    required this.numOfOneStar,
  });

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'numOfReviews': numOfReviews,
    'numOfFiveStar': numOfFiveStar,
    'numOfFourStar': numOfFourStar,
    'numOfThreeStar': numOfThreeStar,
    'numOfTwoStar': numOfTwoStar,
    'numOfOneStar': numOfOneStar,
  };

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
    rating: json['rating'],
    numOfReviews: json['numOfReviews'],
    numOfFiveStar: json['numOfFiveStar'],
    numOfFourStar: json['numOfFourStar'],
    numOfThreeStar: json['numOfThreeStar'],
    numOfTwoStar: json['numOfTwoStar'],
    numOfOneStar: json['numOfOneStar'],
  );
}
//
// class ProductModel {
//   final String title;
//   final String brandName;
//   final String image;
//   final String price;
//   final String priceAfterDiscount;
//   final String discountPercent;
//   final String productInfo;
//   final List<String> imageList;
//   final ProductRating productRating;
//
//   ProductModel({
//     required this.title,
//     required this.brandName,
//     required this.image,
//     required this.price,
//     required this.priceAfterDiscount,
//     required this.discountPercent,
//     required this.productInfo,
//     required this.imageList,
//     required this.productRating,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'title': title,
//     'brandName': brandName,
//     'image': image,
//     'price': price,
//     'priceAfterDiscount': priceAfterDiscount,
//     'discountpercent': discountPercent,
//     'ProductInfo': productInfo,
//     'ImageList': imageList,
//     'ProductRating': productRating.toJson(),
//   };
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//     title: json['title'],
//     brandName: json['brandName'],
//     image: json['image'],
//     price: json['price'],
//     priceAfterDiscount: json['priceAfterDiscount'],
//     discountPercent: json['discountpercent'],
//     productInfo: json['productInfo'],
//     imageList: List<String>.from(json['imageList'] ?? []),
//     productRating:
//     ProductRating.fromJson(json['productRating'] ?? <String, dynamic>{}),
//   );
// }
