import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../constants.dart';
import 'package:projectx/models/product_model.dart';

class ProductReviewsScreen extends StatelessWidget {

  final List<Review>? customerReviewList;

  const ProductReviewsScreen({required this.customerReviewList});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {
        "name": "Aarav Singh",
        "review": "The product is amazing and works exactly as described. Great quality!",
        "rating": 2.5,
        "title": "Impressive",
        "color": "Black",
        "storage": "64 GB",
        "location": "Mumbai",
        "timeAgo": "3 weeks ago",
        "verified": true,
      },
      {
        "name": "Priya Sharma",
        "review": "Worth the money. Packaging was excellent and the delivery was on time.",
        "rating": 5.0,
        "title": "Excellent",
        "location": "Delhi",
        "timeAgo": "1 month ago",
        "verified": true,
      },
      {
        "name": "Rahul Mehta",
        "review": "Good build, feels premium. Minor issue with fitting but manageable.",
        "rating": 4.0,
        "title": "Good Build",
        "location": "Chennai",
        "timeAgo": "2 months ago",
        "verified": false,
      },
      {
        "name": "Simran Kaur",
        "review": "Looks exactly as shown. Satisfied with the quality and design.",
        "rating": 4.8,
        "title": "Satisfied",
        "location": "Bangalore",
        "timeAgo": "1 week ago",
        "verified": true,

      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Reviews"),
      ),
      body: customerReviewList?.length==0? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? "assets/Illustration/Failed_lightTheme.png"
                  : "assets/Illustration/Failed_lightTheme.png",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(height: 30,),
            Text("Mail your review at oliviya.occurance@gmail.com",
              style: Theme.of(context).textTheme.titleSmall!,
            )
          ],
        )
      ):ListView.separated(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: customerReviewList?.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(height: defaultPadding/2.5),
        itemBuilder: (context, index) {
          final r = customerReviewList![index];
          return ProductReviewTile(
            name: r.name,
            rating: r.rating,
            title: r.title,
            review: r.review,
            location: r.location,
            timeAgo: r.timeAgo,
            isVerified: r.verified,
          );
        },
      ),
    );
  }
}

class ProductReviewTile extends StatelessWidget {
  final String name;
  final double rating;
  final String title;
  final String review;
  final String location;
  final bool isVerified;
  final String timeAgo;

  const ProductReviewTile({
    super.key,
    required this.name,
    required this.rating,
    required this.title,
    required this.review,
    required this.location,
    required this.isVerified,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Rating and title
          Row(
            children: [
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.green),
                itemCount: 5,
                itemSize: 18,
                direction: Axis.horizontal,
              ),
              const SizedBox(width: 6),
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "• $title",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Text(
                timeAgo,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 6),

          /// Review content
          Text(
            review,
            style: const TextStyle(fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 12),
          /// Verified & time
          Row(
            children: [
              Text(
                "$name, $location",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10,),
              if (isVerified) ...[
                const Icon(Icons.verified, size: 16, color: Colors.black54),
                const SizedBox(width: 4),
                const Text("Verified Purchase", style: TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(width: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
