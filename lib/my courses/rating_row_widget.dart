import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RatingRowWidget extends StatelessWidget {
  final double initialRating;
  final int itemCount;
  final double percent;

  const RatingRowWidget({
    Key? key,
    required this.initialRating,
    required this.itemCount,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isWebLayout = MediaQuery.of(context).size.width > 600;

    return Row(
      children: [
        RatingBarIndicator(
          rating: initialRating,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Color(0xFFFFDF00),
          ),
          itemCount: itemCount,
          itemSize: isWebLayout ? 16 : 12,
          direction: Axis.horizontal,
        ),
        const SizedBox(width: 8),
        LinearPercentIndicator(
          width: isWebLayout ? 150 : 100,
          lineHeight: isWebLayout ? 6 : 4,
          percent: percent,
          backgroundColor: Colors.grey[300],
          progressColor: const Color(0xFF78A03F),
        ),
        const SizedBox(width: 8),
        Text(
          '${(percent * 100).toInt()}%',
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: isWebLayout ? 14 : 12,
            color: const Color(0xFF000000),
          ),
        ),
      ],
    );
  }
}