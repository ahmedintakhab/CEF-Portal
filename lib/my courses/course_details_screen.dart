import 'dart:convert';
import 'dart:io';
import 'package:cef_dashboard/my%20courses/quiz_screen.dart';
import 'package:cef_dashboard/my%20courses/reviews_screen.dart';
import 'package:cef_dashboard/my%20courses/self_learning_courses.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'assignment_screen.dart';
import '../discussion/discussion_screen.dart';
import 'my_class_screen.dart';
import 'notice_screen.dart';
import 'overview_screen.dart';
import 'content_screen.dart'; // Import the ContentScreen

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
  bool _useIframe = false;

  // PDF related variables
  bool _isPdfMode = false;
  String? _currentPdfPath;
  List<String> _availablePdfs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _initializeVideo();
    _loadAvailablePdfs();
  }

  Future<void> _loadAvailablePdfs() async {
    try {
      // Load PDF files from assets/pdf/ directory
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final pdfFiles = manifestMap.keys
          .where((String key) => key.startsWith('assets/pdf/') && key.endsWith('.pdf'))
          .map((String key) => key.split('/').last)
          .toList();

      setState(() {
        _availablePdfs = pdfFiles;
      });
    } catch (e) {
      // Fallback to hardcoded list if AssetManifest reading fails
      setState(() {
        _availablePdfs = ['flutter_basics.pdf', 'Introduction.pdf', 'Lesson1.pdf', 'Lesson2.pdf'];
      });
    }
  }

  Future<void> _initializeVideo() async {
    if (kIsWeb && _useIframe) {
      setState(() => _isWebVideoReady = true);
    } else {
      _videoController = VideoPlayerController.asset('assets/videos/cef.mp4');
      await _videoController!.initialize();

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

  void _openPdf(String pdfName) {
    // For web and desktop, open PDF inline
    // For mobile, navigate to ContentScreen
    final bool shouldOpenInline = kIsWeb || (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux));

    print('Should open inline: $shouldOpenInline');
    print('PDF to open: assets/pdf/$pdfName');

    if (shouldOpenInline) {
      print('Opening PDF inline');
      setState(() {
        _isPdfMode = true;
        _currentPdfPath = 'assets/pdf/$pdfName';
      });
    } else {
      print('Navigating to ContentScreen');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContentScreen(
              pdfPath: 'assets/pdf/$pdfName',
              pdfName: pdfName,
            ),
          ),
        );
      });
    }
  }

  void _closePdf() {
    setState(() {
      _isPdfMode = false;
      _currentPdfPath = null;
    });
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
            if (_isPdfMode && kIsWeb) {
              // If in PDF mode on Web, close PDF instead of going back
              _closePdf();
            } else if (widget.onBack != null) {
              widget.onBack!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: _isPdfMode && kIsWeb
            ? Text(_currentPdfPath?.split('/').last ?? 'PDF Viewer')
            : const Text('Course Details'),
        actions: (_isPdfMode && kIsWeb) ? [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: _closePdf,
            tooltip: 'Close PDF',
          ),
        ] : null,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMediaPlayer(),
                const SizedBox(height: 16),
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
                      DiscussionPage(),
                      ReviewsScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _buildCourseContentSection(),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Column(
            children: [
              _buildMediaPlayer(),
              const SizedBox(height: 16),
              _buildCourseContentSection(),
            ],
          ),
        ),
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
              DiscussionPage(),
              ReviewsScreen(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaPlayer() {
    if (_isPdfMode && _currentPdfPath != null) {
      return _buildPdfViewer();
    } else {
      return _buildVideoPlayer();
    }
  }

  Widget _buildPdfViewer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SfPdfViewer.asset(
            _currentPdfPath!,
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            canShowScrollHead: true,
            canShowScrollStatus: true,
          ),
        ),
      ),
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
          ExpansionTile(
            title: const Text('PDFs'),
            children: _availablePdfs.map((pdf) => ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(pdf),
              trailing: _isPdfMode && _currentPdfPath == 'assets/pdf/$pdf'
                  ? const Icon(Icons.visibility, color: Colors.blue)
                  : null,
              onTap: () => _openPdf(pdf),
            )).toList(),
          ),
          ExpansionTile(
            title: const Text('Slide Documents'),
            children: slides.map((slide) => ListTile(
              leading: const Icon(Icons.slideshow, color: Colors.orange),
              title: Text(slide),
              onTap: () {
                // Handle slide tap (e.g., open file)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening $slide')),
                );
              },
            )).toList(),
          ),
          if (_isPdfMode && kIsWeb)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _closePdf,
                      icon: const Icon(Icons.video_library),
                      label: const Text('Back to Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}