import 'package:flutter/material.dart';

class LiveCoursesWidget extends StatefulWidget {
  const LiveCoursesWidget({super.key});

  @override
  State<LiveCoursesWidget> createState() => _LiveCoursesWidgetState();
}

class _LiveCoursesWidgetState extends State<LiveCoursesWidget> {
  // Sample live course data
  final List<LiveCourseModel> liveCourses = [
    LiveCourseModel(
      name: "Tajweed ul Quran the easy way (English)",
      price: "Rs. 12,000",
      rating: 4.0,
      imageUrl: "assets/images/cef.png",
    ),
    LiveCourseModel(
      name: "Learn Quranic Arabic the easy way (For Teenagers)",
      price: "Rs. 14,000",
      rating: 3.0,
      imageUrl: "assets/images/cef.png",
    ),
    LiveCourseModel(
      name: "Learn Quranic Arabic the easy way (For Adults)",
      price: "Rs. 7,000",
      rating: 3.0,
      imageUrl: "assets/images/cef.png",
    ),
    LiveCourseModel(
      name: "Tajweed ul Quran Asaan Treeqy sy (Urdu)",
      price: "Rs. 5,000",
      rating: 5.0,
      imageUrl: "assets/images/cef.png",
    ),
    LiveCourseModel(
      name: "Qurani Arbi Seekhain Asaan Tareeqay Se (For Teenagers)",
      price: "Rs. 7,000",
      rating: 0.0,
      imageUrl: "assets/images/cef.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 600;

        return Container(
          color: Colors.white,
          child: Column(
            children: [
              if (isWeb)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: _buildWebHeaders(),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: liveCourses.length,
                  itemBuilder: (context, index) {
                    return isWeb
                        ? _buildWebCourseItem(liveCourses[index])
                        : _buildMobileCourseItem(liveCourses[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWebHeaders() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              const Text('Course Name',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Text('Price',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: Text('Rating',
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
        ),
      ],
    );
  }

  Widget _buildWebCourseItem(LiveCourseModel course) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 40,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[200],
                  ),
                  child: course.imageUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(course.imageUrl!, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _placeholderImage();
                        }),
                  )
                      : _placeholderImage(),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onLiveCourseNameTap(course),
                    child: Text(course.name,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(course.price, style: const TextStyle(color: Colors.black87)),
          ),
          Expanded(
            flex: 1,
            child: _buildRatingStars(course.rating),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCourseItem(LiveCourseModel course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (course.imageUrl != null)
            Container(
              width: double.infinity,
              height: 120,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(course.imageUrl!, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _placeholderImage();
                    }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMobileDetailRowClickable('Course Name:', course.name,
                    onTap: () => _onLiveCourseNameTap(course)),
                const SizedBox(height: 12),
                _buildMobileDetailRow('Price:', course.price),
                const SizedBox(height: 12),
                _buildMobileRatingRow('Rating:', course.rating),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  Widget _buildMobileDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildMobileDetailRowClickable(String label, String value,
      {required VoidCallback onTap}) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Text(value,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline)),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileRatingRow(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
        Expanded(child: _buildRatingStars(rating)),
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index < rating && rating % 1 != 0) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }

  void _onLiveCourseNameTap(LiveCourseModel course) {
    print('Live course tapped: ${course.name}');
  }
}

class LiveCourseModel {
  final String name;
  final String price;
  final double rating;
  final String? imageUrl;

  LiveCourseModel({
    required this.name,
    required this.price,
    required this.rating,
    this.imageUrl,
  });
}
