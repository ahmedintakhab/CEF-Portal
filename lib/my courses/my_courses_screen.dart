// my_courses_screen.dart
import 'package:cef_dashboard/my%20courses/self_learning_courses.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'live_courses_widget.dart';

class MyCoursesWidget extends StatefulWidget {
  final Function(CourseModel)? onCourseSelected; // Callback for course selection
  final VoidCallback? onBackPressed; // Add this callback

  const MyCoursesWidget({super.key, this.onCourseSelected, this.onBackPressed});

  @override
  State<MyCoursesWidget> createState() => _MyCoursesWidgetState();
}

class _MyCoursesWidgetState extends State<MyCoursesWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Courses', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (kIsWeb || !(Theme.of(context).platform == TargetPlatform.android))
            ? null // Hide for web or non-Android platforms
            : IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Use the callback if provided, otherwise default to popping
            if (widget.onBackPressed != null) {
              widget.onBackPressed!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.green,
              indicatorWeight: 3,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
              tabs: const [
                Tab(text: 'Self Learning Courses'),
                Tab(text: 'Live Courses'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SelfLearningCoursesWidget(
                  onCourseSelected: widget.onCourseSelected,
                ),
                LiveCoursesWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}