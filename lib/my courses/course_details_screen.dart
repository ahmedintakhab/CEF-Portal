import 'package:cef_dashboard/my%20courses/quiz_screen.dart';
import 'package:cef_dashboard/my%20courses/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';
import 'assignment_screen.dart';
import 'discussion_screen.dart';
import 'my_class_screen.dart';
import 'notice_screen.dart';
import 'overview_screen.dart';
import 'self_learning_courses.dart';

class CourseDetailsScreen extends StatefulWidget {
  final CourseModel course;
  final VoidCallback? onBack;

  const CourseDetailsScreen({super.key, required this.course, this.onBack});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _videoController = VideoPlayerController.asset('assets/videos/cef.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update when video is initialized
      });
    _videoController.setLooping(false); // Autoplay is false
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final isWebLayout = kIsWeb || screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: isWebLayout
            ? _buildWebLayout()
            : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column - Video and TabBar content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoPlayer(),
                const SizedBox(height: 16),
                // Course name and lessons
                Text(
                  widget.course.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.course.lessons,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                // TabBar with restricted width
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Notice'),
                    Tab(text: 'My Class'),
                    Tab(text: 'Assignments'),
                    Tab(text: 'Quizzes'),
                    Tab(text: 'Discussion'),
                    Tab(text: 'Reviews'),
                  ],
                ),
                // TabBarView
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OverviewScreen(courseName: widget.course.name),
                      NoticeScreen(courseName: widget.course.name),
                      MyClassScreen(courseName: widget.course.name),
                      AssignmentsScreen(courseName: widget.course.name),
                      QuizzesScreen(courseName: widget.course.name),
                      DiscussionScreen(courseName: widget.course.name),
                      ReviewsScreen(courseName: widget.course.name),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right column - Course Content
          _buildCourseContentSection(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video and Course Content section
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Column(
            children: [
              _buildVideoPlayer(),
              const SizedBox(height: 16),
              _buildCourseContentSection(),
            ],
          ),
        ),
        // Course name and lessons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.course.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            widget.course.lessons,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        // TabBar
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Notice'),
            Tab(text: 'My Class'),
            Tab(text: 'Assignments'),
            Tab(text: 'Quizzes'),
            Tab(text: 'Discussion'),
            Tab(text: 'Reviews'),
          ],
        ),
        // TabBarView
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              OverviewScreen(courseName: widget.course.name),
              NoticeScreen(courseName: widget.course.name),
              MyClassScreen(courseName: widget.course.name),
              AssignmentsScreen(courseName: widget.course.name),
              QuizzesScreen(courseName: widget.course.name),
              DiscussionScreen(courseName: widget.course.name),
              ReviewsScreen(courseName: widget.course.name),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          _videoController.value.isInitialized
              ? VideoPlayer(_videoController)
              : Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF8CC13F),),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text(
                    _videoController.value.isInitialized
                        ? '${_videoController.value.position.inSeconds ~/
                        60}:${(_videoController.value.position.inSeconds % 60)
                        .toString()
                        .padLeft(2, '0')} / '
                        '${_videoController.value.duration.inSeconds ~/
                        60}:${(_videoController.value.duration.inSeconds % 60)
                        .toString()
                        .padLeft(2, '0')}'
                        : '0:00 / 0:00',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: VideoProgressIndicator(
                      _videoController,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Colors.white,
                        backgroundColor: Colors.white30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      _videoController.value.isPlaying ? Icons.pause : Icons
                          .play_arrow,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.fullscreen, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseContentSection() {
    final List<String> pdfs = [
      'Introduction.pdf',
      'Lesson1.pdf',
      'Lesson2.pdf'
    ];
    final List<String> slides = ['SlideDeck1.pptx', 'SlideDeck2.pptx'];
    final List<String> videos = ['IntroVideo.mp4', 'Lecture1.mp4'];
    final List<String> audios = ['Audio1.mp3', 'Audio2.mp3'];
    final List<String> images = ['Image1.jpg', 'Image2.jpg'];

    return Container(
      width: 400,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Course Content',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.course.name,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          ExpansionTile(
            title: const Text('PDFs'),
            children: pdfs.map((pdf) =>
                ListTile(
                  title: Text(pdf),
                  onTap: () {
                    // Handle PDF tap (e.g., open file)
                  },
                )).toList(),
          ),
          ExpansionTile(
            title: const Text('Slide Documents'),
            children: slides.map((slide) =>
                ListTile(
                  title: Text(slide),
                  onTap: () {
                    // Handle slide tap (e.g., open file)
                  },
                )).toList(),
          ),
          // ExpansionTile(
          //   title: const Text('Videos'),
          //   children: videos.map((video) =>
          //       ListTile(
          //         title: Text(video),
          //         onTap: () {
          //           // Handle video tap (e.g., open file)
          //         },
          //       )).toList(),
          // ),
          // ExpansionTile(
          //   title: const Text('Audios'),
          //   children: audios.map((audio) =>
          //       ListTile(
          //         title: Text(audio),
          //         onTap: () {
          //           // Handle audio tap (e.g., open file)
          //         },
          //       )).toList(),
          // ),
          // ExpansionTile(
          //   title: const Text('Images'),
          //   children: images.map((image) =>
          //       ListTile(
          //         title: Text(image),
          //         onTap: () {
          //           // Handle image tap (e.g., open file)
          //         },
          //       )).toList(),
          // ),
        ],
      ),
    );
  }
}