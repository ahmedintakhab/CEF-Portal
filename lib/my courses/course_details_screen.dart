import 'package:cef_dashboard/my%20courses/quiz_screen.dart';
import 'package:cef_dashboard/my%20courses/reviews_screen.dart';
import 'package:cef_dashboard/my%20courses/self_learning_courses.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'assignment_screen.dart';
import 'discussion_screen.dart';
import 'my_class_screen.dart';
import 'notice_screen.dart';
import 'overview_screen.dart';

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
  late VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isWebVideoReady = false;
  bool _useIframe = false; // Set to false for offline asset videos

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    if (kIsWeb && _useIframe) {
      // Use iframe for web (online only)
      setState(() => _isWebVideoReady = true);
    } else {
      // Use asset video for both mobile and web (offline support)
      _videoController = VideoPlayerController.asset('assets/videos/cef.mp4');
      await _videoController!.initialize();

      // Initialize Chewie for enhanced controls
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey[300]!,
        ),
        placeholder: Container(
          color: Colors.grey,
          child: const Center(child: CircularProgressIndicator()),
        ),
        autoInitialize: true,
      );

      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
        child: isWebLayout ? _buildWebLayout() : _buildMobileLayout(),
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
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    if (kIsWeb && _useIframe) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: _isWebVideoReady
            ? HtmlWidget(
          '''
                <iframe 
                  width="100%" 
                  height="100%" 
                  src="https://www.youtube.com/embed/YOUR_VIDEO_ID" 
                  frameborder="0" 
                  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
                  allowfullscreen>
                </iframe>
                ''',
        )
            : Container(
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF8CC13F)),
          ),
        ),
      );
    } else {
      if (_chewieController == null ||
          !_chewieController!.videoPlayerController.value.isInitialized) {
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(color: Color(0xFF8CC13F)),
            ),
          ),
        );
      }

      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: _chewieController!),
      );
    }
  }

  Widget _buildCourseContentSection() {
    final List<String> pdfs = ['Introduction.pdf', 'Lesson1.pdf', 'Lesson2.pdf'];
    final List<String> slides = ['SlideDeck1.pptx', 'SlideDeck2.pptx'];

    return Container(
      width: 400,
      padding: const EdgeInsets.all(10.0),
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
          // const SizedBox(height: 8),
          // Text(
          //   widget.course.name,
          //   style: const TextStyle(fontSize: 14),
          //   overflow: TextOverflow.ellipsis,
          // ),
          // const SizedBox(height: 6),
          ExpansionTile(
            title: const Text('PDFs'),
            children: pdfs.map((pdf) => ListTile(
              title: Text(pdf),
              onTap: () {
                // Handle PDF tap (e.g., open file)
              },
            )).toList(),
          ),
          ExpansionTile(
            title: const Text('Slide Documents'),
            children: slides.map((slide) => ListTile(
              title: Text(slide),
              onTap: () {
                // Handle slide tap (e.g., open file)
              },
            )).toList(),
          ),
        ],
      ),
    );
  }
}