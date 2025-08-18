// self_learning_courses.dart
import 'package:flutter/material.dart';
import 'course_details_screen.dart';

class CourseModel {
  final String name;
  final String lessons;
  final String price;
  final String orderId;
  final String validity;
  final double progress;
  final String status;

  CourseModel({
    required this.name,
    required this.lessons,
    required this.price,
    required this.orderId,
    required this.validity,
    required this.progress,
    required this.status,
  });
}

class SelfLearningCoursesWidget extends StatelessWidget {
  final Function(CourseModel)? onCourseSelected; // Callback for course selection

  SelfLearningCoursesWidget({super.key, this.onCourseSelected});

  // Sample course data
  final List<CourseModel> selfLearningCourses = [
    CourseModel(
      name: "Learn Tajweed The Easy Way (Self-Learning Course)",
      lessons: "1 lessons | 18 lectures",
      price: "Free",
      orderId: "29",
      validity: "Lifetime",
      progress: 14.29,
      status: "In Progress",
    ),
    CourseModel(
      name: "Arabic Grammar Fundamentals",
      lessons: "2 lessons | 25 lectures",
      price: "₹2,999",
      orderId: "30",
      validity: "6 months",
      progress: 45.0,
      status: "In Progress",
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
                  itemCount: selfLearningCourses.length,
                  itemBuilder: (context, index) {
                    return isWeb
                        ? _buildWebCourseItem(context, selfLearningCourses[index])
                        : _buildMobileCourseItem(context, selfLearningCourses[index]);
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
      children: const [
        Expanded(flex: 3, child: _HeaderText("Course Name")),
        Expanded(flex: 1, child: _HeaderText("Price")),
        Expanded(flex: 1, child: _HeaderText("Order ID")),
        Expanded(flex: 1, child: _HeaderText("Validity")),
        Expanded(flex: 1, child: Text('Progress', style: _headerStyle)),
        Expanded(flex: 1, child: Text('Status', style: _headerStyle)),
      ],
    );
  }

  Widget _buildWebCourseItem(BuildContext context, CourseModel course) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (onCourseSelected != null) {
                      onCourseSelected!(course); // Trigger callback
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailsScreen(course: course),
                        ),
                      );
                    }
                  },
                  child: Text(
                    course.name,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(course.lessons, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Expanded(flex: 1, child: Text(course.price)),
          Expanded(flex: 1, child: Text(course.orderId)),
          Expanded(flex: 1, child: Text(course.validity)),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: course.progress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 4),
                Text('${course.progress.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(4)),
              child: Text(
                course.status,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue[800], fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCourseItem(BuildContext context, CourseModel course) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mobileRowClickable("Course Name:", course.name, () {
            if (onCourseSelected != null) {
              onCourseSelected!(course); // Trigger callback
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetailsScreen(course: course),
                ),
              );
            }
          }),
          _mobileRow("Lessons:", course.lessons),
          _mobileRow("Price:", course.price),
          _mobileRow("Order ID:", course.orderId),
          _mobileRow("Validity:", course.validity),
          _mobileProgressRow("Progress:", course.progress),
          _mobileStatusRow("Status:", course.status),
        ],
      ),
    );
  }

  Widget _mobileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: _labelStyle)),
          Expanded(child: Text(value, style: _valueStyle)),
        ],
      ),
    );
  }

  Widget _mobileRowClickable(String label, String value, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: _labelStyle)),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileProgressRow(String label, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: _labelStyle)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 4),
                Text('${progress.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileStatusRow(String label, String status) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 100, child: Text(label, style: _labelStyle)),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(4)),
            child: Text(status, style: TextStyle(color: Colors.blue[800], fontSize: 12, fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: _headerStyle),
        const SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
      ],
    );
  }
}

const _headerStyle = TextStyle(fontWeight: FontWeight.w600, color: Colors.black87);
const _labelStyle = TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500);
const _valueStyle = TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500);