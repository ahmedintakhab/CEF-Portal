// // my_course_details.dart
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../my courses/self_learning_courses.dart';
//
// // import 'self_learning_courses.dart'; // Import for CourseModel
//
// class MyCourseDetails extends StatefulWidget {
//   final CourseModel course;
//   final VoidCallback onBack;
//
//   const MyCourseDetails({super.key, required this.course, required this.onBack});
//
//   @override
//   State<MyCourseDetails> createState() => _MyCourseDetailsState();
// }
//
// class _MyCourseDetailsState extends State<MyCourseDetails> with SingleTickerProviderStateMixin {
//   late VideoPlayerController _videoController;
//   late TabController _tabController;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _videoController = VideoPlayerController.asset(
//       'assets/videos/college.mp4',
//     )..initialize().then((_) {
//       setState(() {});
//     });
//
//     _tabController = TabController(length: 5, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _videoController.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void _togglePlayPause() {
//     setState(() {
//       if (_videoController.value.isPlaying) {
//         _videoController.pause();
//         _isPlaying = false;
//       } else {
//         _videoController.play();
//         _isPlaying = true;
//       }
//     });
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         bool isWeb = constraints.maxWidth > 600;
//
//         return isWeb
//             ? Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               flex: 2,
//               child: _buildMainContent(context),
//             ),
//             Expanded(
//               flex: 1,
//               child: _buildCourseContent(context),
//             ),
//           ],
//         )
//             : _buildMainContent(context);
//       },
//     );
//   }
//
//   Widget _buildMainContent(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: widget.onBack,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 'Course Details',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           _videoController.value.isInitialized
//               ? Column(
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: _videoController.value.aspectRatio,
//                     child: VideoPlayer(_videoController),
//                   ),
//                   IconButton(
//                     iconSize: 64,
//                     icon: Icon(
//                       _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
//                       color: Colors.white,
//                     ),
//                     onPressed: _togglePlayPause,
//                   ),
//                 ],
//               ),
//               VideoProgressIndicator(
//                 _videoController,
//                 allowScrubbing: true,
//                 colors: const VideoProgressColors(
//                   playedColor: Color(0xFF0E4D92),
//                   bufferedColor: Colors.grey,
//                   backgroundColor: Colors.black26,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(_formatDuration(_videoController.value.position)),
//                     Text(_formatDuration(_videoController.value.duration)),
//                   ],
//                 ),
//               ),
//             ],
//           )
//               : const Center(child: CircularProgressIndicator()),
//           const SizedBox(height: 16),
//           Text(
//             widget.course.name,
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 8),
//           Text(widget.course.lessons),
//           const SizedBox(height: 16),
//           TabBar(
//             controller: _tabController,
//             isScrollable: true,
//             indicatorColor: const Color(0xFF0E4D92),
//             labelColor: const Color(0xFF0E4D92),
//             unselectedLabelColor: Colors.grey,
//             tabs: const [
//               Tab(text: 'Overview'),
//               Tab(text: 'Notice'),
//               Tab(text: 'My Class'),
//               Tab(text: 'Assignments'),
//               Tab(text: 'Quizzes'),
//             ],
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 800,
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildOverviewTab(),
//                 const Center(child: Text('Notice Content')),
//                 const Center(child: Text('My Class Content')),
//                 const Center(child: Text('Assignments Content')),
//                 const Center(child: Text('Quizzes Content')),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCourseContent(BuildContext context) {
//     return Container(
//       color: Colors.grey[100],
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Course Content',
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             const SizedBox(height: 16),
//             ListTile(
//               title: const Text('Self Learning Online Course'),
//               trailing: const Icon(Icons.expand_more),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOverviewTab() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               color: const Color(0xFF0E4D92),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.mosque, color: Colors.white),
//                 const SizedBox(width: 8),
//                 Text(
//                   'Tajweed Excellence Course',
//                   style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildCardContainer(
//             title: 'Description',
//             child: const Text(
//               'Basic to Advance Tajweed with Expert-Led Techniques in a Self-Learning Experience',
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildCardContainer(
//             title: 'What You Will Learn:',
//             icon: Icons.lightbulb,
//             iconColor: const Color(0xFF0E4D92),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildListItem('Fundamental principles and rules of Tajweed', Icons.check, Colors.green),
//                 _buildListItem('Correct pronunciation of Arabic letters (Makharij)', Icons.check, Colors.green),
//                 _buildListItem('Common mistakes in recitation and how to avoid them', Icons.check, Colors.green),
//                 _buildListItem('Get Free Access to All Resources in Curriculum Section', Icons.check, Colors.green),
//                 _buildListItem('Application of Tajweed rules in Quranic recitation', Icons.check, Colors.green),
//                 _buildListItem('Practical exercises to reinforce learning and fluency', Icons.check, Colors.green),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildCardContainer(
//             title: 'Course Overview:',
//             icon: Icons.menu_book,
//             iconColor: Colors.purple,
//             child: const Text(
//               'This self-based online course is designed to help learners perfect their Quranic recitation by mastering the rules of Tajweed. Whether you\'re a beginner or looking to refine your skills, this comprehensive course provides the tools and techniques to enhance your recitation and connect more deeply with the Holy Quran.',
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildCardContainer(
//             title: 'Features:',
//             icon: Icons.star,
//             iconColor: Colors.amber,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildListItem('Flexible Learning: Study at your own pace with access to all course materials anytime, anywhere.', Icons.check, Colors.green),
//                 _buildListItem('Interactive Lessons: Engage with video tutorials, audio examples, and quizzes to test your understanding.', Icons.check, Colors.green),
//                 _buildListItem('Expert Guidance: Learn from experienced Quran teachers with in-depth knowledge of tajweed.', Icons.check, Colors.green),
//                 _buildListItem('Practice Opportunities: Regular exercises and recitation practice to enhance your skills.', Icons.check, Colors.green),
//                 _buildListItem('Certificate of Completion: Earn a certificate upon successful completion of the course.', Icons.check, Colors.green),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           _buildCardContainer(
//             title: 'Who Should Enroll?',
//             icon: Icons.person,
//             iconColor: Colors.purple,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildListItem('Beginners seeking to learn the basics of Tajweed.', Icons.circle, Colors.blue, isBullet: true),
//                 _buildListItem('Intermediate learners aiming to improve their Quranic recitation.', Icons.circle, Colors.blue, isBullet: true),
//                 _buildListItem('Advanced students looking to perfect their Tajweed skills.', Icons.circle, Colors.blue, isBullet: true),
//                 _buildListItem('Anyone passionate about enhancing their connection with the Quran through proper recitation.', Icons.circle, Colors.blue, isBullet: true),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCardContainer({
//     required String title,
//     IconData? icon,
//     Color? iconColor,
//     required Widget child,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               if (icon != null) ...[
//                 Icon(icon, color: iconColor, size: 20),
//                 const SizedBox(width: 8),
//               ],
//               Text(
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           child,
//         ],
//       ),
//     );
//   }
//
//   Widget _buildListItem(String text, IconData icon, Color iconColor, {bool isBullet = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (isBullet)
//             Icon(icon, size: 10, color: iconColor)
//           else
//             Icon(icon, size: 18, color: iconColor),
//           const SizedBox(width: 8),
//           Expanded(child: Text(text)),
//         ],
//       ),
//     );
//   }
// }