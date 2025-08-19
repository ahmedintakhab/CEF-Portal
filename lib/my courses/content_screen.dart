import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ContentScreen extends StatelessWidget {
  final String pdfPath;
  final String pdfName;

  const ContentScreen({super.key, required this.pdfPath, required this.pdfName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(pdfName),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
        enableDoubleTapZooming: true,
        enableTextSelection: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}