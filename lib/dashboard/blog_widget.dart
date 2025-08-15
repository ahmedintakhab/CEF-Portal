// blog_widget.dart
import 'package:flutter/material.dart';

class BlogWidget extends StatelessWidget {
  BlogWidget({super.key});

  final List<Map<String, String>> blogs = [
    {
      'image': 'assets/images/cef.png', // Replace with actual asset path
      'date': '23-05-2025',
      'title': 'Fahm-ul-Quran - A Transformative Learning Experience',
    },
    {
      'image': 'assets/images/cef.png', // Replace with actual asset path
      'date': '03-01-2025',
      'title': 'Seerat Kahani: A Complete Guide to the Life of Prophet Muhammad (PBUH) for Young Minds',
    },
    {
      'image': 'assets/images/cef.png', // Replace with actual asset path
      'date': '13-12-2024',
      'title': 'Ramadan Goal: Recite a Full Quran in Ramadan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Blogs',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blog = blogs[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        blog['image']!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog['date']!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            blog['title']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}