import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  final String courseName;

  const OverviewScreen({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Description Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
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
                Row(
                  children: [
                    Icon(Icons.description, color: Colors.blue, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Course Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'The '),
                      TextSpan(
                        text: 'Understand Quran Course',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' is a research-backed, expertly designed program developed over nearly 30 years. It offers a structured and interactive approach to Quranic learning using modern techniques like Total Physical Interaction (TPI) and activity-based learning.\n\n'
                            'Guided by experienced and qualified instructors, the course focuses on building a strong foundation in Quranic grammar and vocabulary, enabling learners to understand and translate the Quran directly. Whether you\'re a beginner or already familiar with Quranic Arabic, this course ensures a progressive, engaging, and spiritually enriching experience for all levels.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Course Content Highlights Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
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
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlue,
                        shape: BoxShape.rectangle,
                      ),
                      child: const Icon(Icons.highlight, color: Colors.white, size: 14),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Course Content Highlights',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildHighlightItem('Quranic Content:', 'Selected Surahs from the last Juz, Parts of Salah and related dua\'s'),
                const SizedBox(height: 12),
                _buildHighlightItem('Grammar Modules:', 'Ilm-us-Sarf (Word formation techniques), Ilm-un-Nahw (Sentence structure), Verb patterns and frequencies in the Quran'),
                const SizedBox(height: 12),
                _buildHighlightItem('', 'Singular, dual, and plural forms (masculine & feminine recognition)'),
                const SizedBox(height: 12),
                _buildHighlightItem('', 'Practice through Total Physical Interaction (TPI)'),
                const SizedBox(height: 12),
                _buildHighlightItem('', 'Use of Arabic conversational phrases for deeper understanding'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Who Should Enroll Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
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
                Row(
                  children: [
                    const Text(
                      '👥',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Who Should Enroll?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildEnrollmentItem('Adults who want to understand what they recite in Salah'),
                const SizedBox(height: 8),
                _buildEnrollmentItem('Youth and college students eager to engage with the Quran'),
                const SizedBox(height: 8),
                _buildEnrollmentItem('Parents looking to set an example for their children'),
                const SizedBox(height: 8),
                _buildEnrollmentItem('Teachers and Islamic educators seeking deeper insight'),
                const SizedBox(height: 8),
                _buildEnrollmentItem('Anyone who wishes to connect with the Quran spiritually and intellectually'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Why This Course Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
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
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 14),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Why This Course?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildWhyItem('Backed by 30 years of research and refinement'),
                const SizedBox(height: 8),
                _buildWhyItem('Based on Total Physical Interaction (TPI) and activity-based learning'),
                const SizedBox(height: 8),
                _buildWhyItem('Delivered by highly qualified male and female instructors'),
                const SizedBox(height: 8),
                _buildWhyItem('Flexible class timings for international students'),
                const SizedBox(height: 8),
                _buildWhyItem('Goal-based tracking, daily reports, and feedback'),
                const SizedBox(height: 8),
                _buildWhyItem('Builds a lifelong relationship with the Quran'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnrollmentItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16, color: Colors.orange)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWhyItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16, color: Colors.green)),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}