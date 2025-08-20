import 'package:flutter/material.dart';
import 'rating_row_widget.dart';
import 'write_review_dialog.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  // Static review data
  final Map<String, dynamic> reviewData = {
    'average_rating': 4.5,
    'total_user_reviews': 120,
    'five_star_percentage': 50,
    'four_star_percentage': 25,
    'three_star_percentage': 20,
    'two_star_percentage': 15,
    'first_star_percentage': 10,
    'can_review': true,
    'user_reviews': [
      {
        'user_name': 'Ahmed Meer',
        'comment': 'This course was amazing! Learned a lot about the subject and the instructor was very clear.',
        'created_at': '2025-08-01',
        'rating': 5,
      },
      {
        'user_name': 'Ali Hassan',
        'comment': 'Good content but could use more practical examples.',
        'created_at': '2025-07-28',
        'rating': 4,
      },
      {
        'user_name': 'Alex Brown',
        'comment': 'Decent course, but some sections were a bit confusing.',
        'created_at': '2025-07-20',
        'rating': 3,
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final bool isWebLayout = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isWebLayout ? 40 : 20),
          child: isWebLayout ? buildWebLayout() : buildMobileLayout(),
        ),
      ),
    );
  }

  Widget buildWebLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rating & Reviews",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Gilroy',
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            // const Text(
            //   "View All",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontFamily: 'Gilroy',
            //     color: Color(0xFF000000),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  reviewData['average_rating'].toString(),
                  style: const TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 48,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "out of 5",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 18,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RatingRowWidget(
                  initialRating: 5,
                  itemCount: 5,
                  percent: (reviewData['five_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 10),
                RatingRowWidget(
                  initialRating: 4,
                  itemCount: 4,
                  percent: (reviewData['four_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 10),
                RatingRowWidget(
                  initialRating: 3,
                  itemCount: 3,
                  percent: (reviewData['three_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 10),
                RatingRowWidget(
                  initialRating: 2,
                  itemCount: 2,
                  percent: (reviewData['two_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 10),
                RatingRowWidget(
                  initialRating: 1,
                  itemCount: 1,
                  percent: (reviewData['first_star_percentage'] ?? 0) / 100,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${reviewData['total_user_reviews']} Reviews',
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 16,
              color: Color(0xFF000000),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (reviewData['can_review'] == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const WriteReviewDialog();
                    },
                  );
                },
                child: const Text(
                  "Write A Review",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16,
                    color: Color(0xFF78A03F),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF78A03F),
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 24),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5, // Ensure enough height for scrolling
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: reviewData['user_reviews']?.length ?? 0,
            itemBuilder: (context, index) {
              final userReviews = reviewData['user_reviews'];
              if (userReviews == null) return const SizedBox.shrink();
              final userReview = userReviews[index];
              if (userReview == null) return const SizedBox.shrink();
              return ReviewListItem(userReview: userReview);
            },
          ),
        ),
      ],
    );
  }

  Widget buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Rating & Reviews",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Gilroy',
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            // const Text(
            //   "View All",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontFamily: 'Gilroy',
            //     color: Color(0xFF000000),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  reviewData['average_rating'].toString(),
                  style: const TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 26,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  "out of 5",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 15,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RatingRowWidget(
                  initialRating: 5,
                  itemCount: 5,
                  percent: (reviewData['five_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 5),
                RatingRowWidget(
                  initialRating: 4,
                  itemCount: 4,
                  percent: (reviewData['four_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 5),
                RatingRowWidget(
                  initialRating: 3,
                  itemCount: 3,
                  percent: (reviewData['three_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 5),
                RatingRowWidget(
                  initialRating: 2,
                  itemCount: 2,
                  percent: (reviewData['two_star_percentage'] ?? 0) / 100,
                ),
                const SizedBox(height: 5),
                RatingRowWidget(
                  initialRating: 1,
                  itemCount: 1,
                  percent: (reviewData['first_star_percentage'] ?? 0) / 100,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${reviewData['total_user_reviews']} Reviews',
            style: const TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 12,
              color: Color(0xFF000000),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (reviewData['can_review'] == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const WriteReviewDialog();
                    },
                  );
                },
                child: const Text(
                  "Write A Review",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 16,
                    color: Color(0xFF78A03F),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFF78A03F),
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: reviewData['user_reviews']?.length ?? 0,
          itemBuilder: (context, index) {
            final userReviews = reviewData['user_reviews'];
            if (userReviews == null) return const SizedBox.shrink();
            final userReview = userReviews[index];
            if (userReview == null) return const SizedBox.shrink();
            return ReviewListItem(userReview: userReview);
          },
        ),
      ],
    );
  }
}

class ReviewListItem extends StatefulWidget {
  final Map<String, dynamic> userReview;

  const ReviewListItem({
    Key? key,
    required this.userReview,
  }) : super(key: key);

  @override
  _ReviewListItemState createState() => _ReviewListItemState();
}

class _ReviewListItemState extends State<ReviewListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row for username and created_at
              if (widget.userReview['user_name'] != null || widget.userReview['created_at'] != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.userReview['user_name'] != null)
                      Text(
                        widget.userReview['user_name'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF292929),
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    if (widget.userReview['created_at'] != null)
                      Text(
                        widget.userReview['created_at'].toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF5E8421),
                          fontFamily: 'Gilroy',
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 4),
              if (widget.userReview['comment'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userReview['comment'].toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF292929),
                        fontFamily: 'Gilroy',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: isExpanded ? null : 2,
                      overflow: isExpanded
                          ? TextOverflow.clip
                          : TextOverflow.ellipsis,
                    ),
                    if (_needsReadMore(widget.userReview['comment'].toString()))
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? 'Read less' : 'Read more...',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF78A03F),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  bool _needsReadMore(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'Gilroy',
        ),
      ),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width * 0.8);
    return textPainter.didExceedMaxLines;
  }
}