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
import 'content_screen.dart';

// Full-screen PDF viewer page
class FullScreenPdfViewer extends StatelessWidget {
  final String? pdfPath;
  final String? imagePath;
  final String pdfName;

  const FullScreenPdfViewer({super.key, this.pdfPath, this.imagePath, required this.pdfName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfName),
        actions: [
          IconButton(
            icon: const Icon(Icons.fullscreen_exit,color: Colors.black,),
            onPressed: () {
              // Reset system UI and orientation
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Navigator.pop(context);
            },
            tooltip: 'Exit Full Screen',
          ),
        ],
      ),
      body: imagePath != null
          ? Center(
        child: Image.asset(
          imagePath!,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
            );
          },
        ),
      )
          : SfPdfViewer.asset(
        pdfPath!,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}

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
    if (widget.course.imageUrl == null) {
      _initializeVideo();
    }
  }

  Future<void> _loadAvailablePdfs() async {
    try {
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

  void _toggleFullScreen(String path, String name, bool isImage) {
    // Set system UI to immersive and landscape orientation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Navigate to full-screen viewer
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenPdfViewer(
          pdfPath: isImage ? null : path,
          imagePath: isImage ? path : null,
          pdfName: name,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
    // Reset system UI and orientation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
    return Stack(
      children: [
        _isPdfMode && _currentPdfPath != null
            ? _buildPdfViewer()
            : widget.course.imageUrl != null
            ? _buildImageViewer()
            : _buildVideoPlayer(),
        if (_isPdfMode && _currentPdfPath != null)
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => _toggleFullScreen(_currentPdfPath!, _currentPdfPath!.split('/').last, false),
              tooltip: 'Enter Full Screen',
            ),
          ),
        if (!_isPdfMode && widget.course.imageUrl != null)
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(
                Icons.fullscreen,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => _toggleFullScreen(widget.course.imageUrl!, widget.course.name, true),
              tooltip: 'Enter Full Screen',
            ),
          ),
      ],
    );
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

  Widget _buildImageViewer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            widget.course.imageUrl!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                ),
              );
            },
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
                      label: Text(widget.course.imageUrl != null ? 'Back to Image' : 'Back to Video'),
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